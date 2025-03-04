//Meteors probability of spawning during a given wave
GLOBAL_LIST_INIT(meteors_normal, list(/obj/effect/meteor/dust=3, /obj/effect/meteor/medium=8, /obj/effect/meteor/big=3, \
						  /obj/effect/meteor/flaming=1, /obj/effect/meteor/irradiated=3)) //for normal meteor event

GLOBAL_LIST_INIT(meteors_threatening, list(/obj/effect/meteor/medium=4, /obj/effect/meteor/big=8, \
						  /obj/effect/meteor/flaming=3, /obj/effect/meteor/irradiated=3)) //for threatening meteor event

GLOBAL_LIST_INIT(meteors_catastrophic, list(/obj/effect/meteor/medium=5, /obj/effect/meteor/big=75, \
						  /obj/effect/meteor/flaming=10, /obj/effect/meteor/irradiated=10, /obj/effect/meteor/tunguska = 1)) //for catastrophic meteor event

GLOBAL_LIST_INIT(meteors_dust, list(/obj/effect/meteor/dust)) //for space dust event

GLOBAL_LIST_INIT(meteors_gore, list(/obj/effect/meteor/gore)) //Meaty Gore

GLOBAL_LIST_INIT(meteors_ops, list(/obj/effect/meteor/goreops)) //Meaty Ops


///////////////////////////////
//Meteor spawning global procs
///////////////////////////////
/proc/spawn_meteors(var/number = 10, var/list/meteortypes)
	for(var/i = 0; i < number; i++)
		spawn_meteor(meteortypes)

/proc/spawn_meteor(var/list/meteortypes)
	var/turf/pickedstart
	var/turf/pickedgoal
	var/max_i = 10//number of tries to spawn meteor.
	while(!isspaceturf(pickedstart))
		var/startSide = pick(GLOB.cardinal)
		var/level = pick(levels_by_trait(STATION_LEVEL))
		pickedstart = spaceDebrisStartLoc(startSide, level)
		pickedgoal = spaceDebrisFinishLoc(startSide, level)
		max_i--
		if(max_i<=0)
			return
	var/Me = pickweight(meteortypes)
	var/obj/effect/meteor/M = new Me(pickedstart)
	M.dest = pickedgoal
	M.z_original = pick(levels_by_trait(STATION_LEVEL))
	spawn(0)
		walk_towards(M, M.dest, 1)
	return

/proc/spaceDebrisStartLoc(startSide, Z)
	var/starty
	var/startx
	switch(startSide)
		if(NORTH)
			starty = world.maxy-(TRANSITIONEDGE+1)
			startx = rand((TRANSITIONEDGE+1), world.maxx-(TRANSITIONEDGE+1))
		if(EAST)
			starty = rand((TRANSITIONEDGE+1),world.maxy-(TRANSITIONEDGE+1))
			startx = world.maxx-(TRANSITIONEDGE+1)
		if(SOUTH)
			starty = (TRANSITIONEDGE+1)
			startx = rand((TRANSITIONEDGE+1), world.maxx-(TRANSITIONEDGE+1))
		if(WEST)
			starty = rand((TRANSITIONEDGE+1), world.maxy-(TRANSITIONEDGE+1))
			startx = (TRANSITIONEDGE+1)
	var/turf/T = locate(startx, starty, Z)
	return T

/proc/spaceDebrisFinishLoc(startSide, Z)
	var/endy
	var/endx
	switch(startSide)
		if(NORTH)
			endy = TRANSITIONEDGE
			endx = rand(TRANSITIONEDGE, world.maxx-TRANSITIONEDGE)
		if(EAST)
			endy = rand(TRANSITIONEDGE, world.maxy-TRANSITIONEDGE)
			endx = TRANSITIONEDGE
		if(SOUTH)
			endy = world.maxy-TRANSITIONEDGE
			endx = rand(TRANSITIONEDGE, world.maxx-TRANSITIONEDGE)
		if(WEST)
			endy = rand(TRANSITIONEDGE,world.maxy-TRANSITIONEDGE)
			endx = world.maxx-TRANSITIONEDGE
	var/turf/T = locate(endx, endy, Z)
	return T

///////////////////////
//The meteor effect
//////////////////////

/obj/effect/meteor
	name = "the concept of meteor"
	desc = "You should probably run instead of gawking at this."
	icon = 'icons/obj/meteor.dmi'
	icon_state = "small"
	density = 1
	anchored = TRUE
	var/hits = 4
	var/hitpwr = 2 //Level of ex_act to be called on hit.
	var/dest
	pass_flags = PASSTABLE
	var/heavy = 0
	var/meteorsound = 'sound/effects/meteorimpact.ogg'
	var/z_original = 1

	var/meteordrop = /obj/item/stack/ore/iron
	var/dropamt = 2

/obj/effect/meteor/Initialize(mapload)
	. = ..()
	z_original = z

/obj/effect/meteor/Move()
	if(z != z_original || loc == dest)
		qdel(src)
		return

	. = ..() //process movement...

	if(.)//.. if did move, ram the turf we get in
		var/turf/T = get_turf(loc)
		ram_turf(T)

		if(prob(10) && !isspaceturf(T))//randomly takes a 'hit' from ramming
			get_hit()

	return .

/obj/effect/meteor/Destroy()
	GLOB.meteor_list -= src
	walk(src,0) //this cancels the walk_towards() proc
	return ..()

/obj/effect/meteor/New()
	..()
	GLOB.meteor_list += src
	SpinAnimation()

/obj/effect/meteor/Bump(atom/A)
	if(A)
		ram_turf(get_turf(A))
		playsound(src.loc, meteorsound, 40, 1)
		get_hit()


/obj/effect/meteor/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(istype(mover, /obj/effect/meteor))
		return TRUE


/obj/effect/meteor/proc/ram_turf(var/turf/T)
	//first bust whatever is in the turf
	for(var/atom/A in T)
		if(A != src)
			A.ex_act(hitpwr)

	//then, ram the turf if it still exists
	if(T)
		T.ex_act(hitpwr)

//process getting 'hit' by colliding with a dense object
//or randomly when ramming turfs
/obj/effect/meteor/proc/get_hit()
	hits--
	if(hits <= 0)
		make_debris()
		meteor_effect(heavy)
		qdel(src)

/obj/effect/meteor/ex_act()
	return

/obj/effect/meteor/attackby(obj/item/W as obj, mob/user as mob, params)
	if(istype(W, /obj/item/pickaxe))
		make_debris()
		qdel(src)
		return
	return ..()

/obj/effect/meteor/proc/make_debris()
	for(var/throws = dropamt, throws > 0, throws--)
		var/obj/item/O = new meteordrop(get_turf(src))
		O.throw_at(dest, 5, 10)

/obj/effect/meteor/proc/meteor_effect(var/sound=1)
	if(sound)
		var/sound/meteor_sound = sound(meteorsound)
		var/random_frequency = get_rand_frequency()

		for(var/P in GLOB.player_list)
			var/mob/M = P
			var/turf/T = get_turf(M)
			if(!T || T.z != src.z)
				continue
			var/dist = get_dist(M.loc, src.loc)
			if(prob(50))
				shake_camera(M, dist > 20 ? 3 : 5, dist > 20 ? 1 : 3)
			M.playsound_local(src.loc, null, 50, 1, random_frequency, 10, S = meteor_sound)

///////////////////////
//Meteor types
///////////////////////

//Dust
/obj/effect/meteor/dust
	name = "space dust"
	icon_state = "dust"
	pass_flags = PASSTABLE | PASSGRILLE
	hits = 1
	hitpwr = 3
	meteorsound = 'sound/weapons/tap.ogg'
	meteordrop = /obj/item/stack/ore/glass

//Medium-sized
/obj/effect/meteor/medium
	name = "meteor"
	dropamt = 3

/obj/effect/meteor/medium/meteor_effect()
	..(heavy)
	explosion(src.loc, 0, 1, 2, 3, 0, cause = src)

//Large-sized
/obj/effect/meteor/big
	name = "large meteor"
	icon_state = "large"
	hits = 6
	heavy = 1
	dropamt = 4

/obj/effect/meteor/big/meteor_effect()
	..(heavy)
	explosion(src.loc, 1, 2, 3, 4, 0, cause = src)

//Flaming meteor
/obj/effect/meteor/flaming
	name = "flaming meteor"
	icon_state = "flaming"
	hits = 5
	heavy = 1
	meteorsound = 'sound/effects/bamf.ogg'
	meteordrop = /obj/item/stack/ore/plasma

/obj/effect/meteor/flaming/meteor_effect()
	..(heavy)
	explosion(src.loc, 1, 2, 3, 4, 0, 0, flame_range = 5, cause = src)

//Radiation meteor
/obj/effect/meteor/irradiated
	name = "glowing meteor"
	icon_state = "glowing"
	heavy = 1
	meteordrop = /obj/item/stack/ore/uranium


/obj/effect/meteor/irradiated/meteor_effect()
	..(heavy)
	explosion(src.loc, 0, 0, 4, 3, 0, cause = src)
	new /obj/effect/decal/cleanable/greenglow(get_turf(src))
	for(var/mob/living/L in view(5, src))
		L.apply_effect(40, IRRADIATE)

//Station buster Tunguska
/obj/effect/meteor/tunguska
	name = "tunguska meteor"
	icon_state = "flaming"
	desc = "Your life briefly passes before your eyes the moment you lay them on this monstruosity."
	hits = 30
	hitpwr = 1
	heavy = 1
	meteorsound = 'sound/effects/bamf.ogg'
	meteordrop = /obj/item/stack/ore/plasma

/obj/effect/meteor/tunguska/meteor_effect()
	..(heavy)
	explosion(src.loc, 5, 10, 15, 20, 0, cause = src)

/obj/effect/meteor/tunguska/Bump()
	..()
	if(prob(20))
		explosion(src.loc,2,4,6,8, cause = src)


//Gore
/obj/effect/meteor/gore
	name = "Oraganic Debris"
	icon = 'icons/mob/human.dmi'
	icon_state = "body_m_s"
	hits = 1
	hitpwr = 0
	meteorsound = 'sound/effects/blobattack.ogg'
	meteordrop = /obj/item/reagent_containers/food/snacks/meat
	var/meteorgibs = /obj/effect/gibspawner/generic

/obj/effect/meteor/gore/make_debris()
	..()
	new meteorgibs(get_turf(src))


/obj/effect/meteor/gore/ram_turf(turf/T)
	if(!isspaceturf(T))
		new /obj/effect/decal/cleanable/blood(T)

/obj/effect/meteor/gore/Bump(atom/A)
	A.ex_act(hitpwr)
	get_hit()

//Meteor Ops
/obj/effect/meteor/goreops
	name = "MeteorOps"
	icon = 'icons/mob/animal.dmi'
	icon_state = "syndicaterangedpsace"
	hits = 10
	hitpwr = 1
	meteorsound = 'sound/effects/blobattack.ogg'
	meteordrop = /obj/item/reagent_containers/food/snacks/meat
	var/meteorgibs = /obj/effect/gibspawner/generic

/obj/effect/meteor/goreops/make_debris()
	..()
	new meteorgibs(get_turf(src))


/obj/effect/meteor/goreops/ram_turf(turf/T)
	if(!isspaceturf(T))
		new /obj/effect/decal/cleanable/blood(T)

/obj/effect/meteor/goreops/Bump(atom/A)
	A.ex_act(hitpwr)
	get_hit()
