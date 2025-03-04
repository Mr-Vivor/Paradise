/obj/structure/chair/wheelchair
	name = "wheelchair"
	icon_state = "wheelchair"
	item_chair = null
	movable = TRUE
	pull_push_speed_modifier = 1
	var/mutable_appearance/chair_overlay
	var/move_delay = null

/obj/structure/chair/wheelchair/handle_rotation()
	if(chair_overlay)
		cut_overlay(chair_overlay)
	else
		chair_overlay = mutable_appearance(icon, "[icon_state]_overlay", FLY_LAYER)
	chair_overlay.dir = src.dir
	add_overlay(chair_overlay)
	if(has_buckled_mobs())
		for(var/m in buckled_mobs)
			var/mob/living/buckled_mob = m
			buckled_mob.setDir(dir)

/obj/structure/chair/wheelchair/relaymove(mob/user, direction)
	if(propelled)
		return 0

	if(!Process_Spacemove(direction) || !has_gravity(loc) || !isturf(loc))
		return 0

	if(world.time < move_delay)
		return

	var/calculated_move_delay
	calculated_move_delay += 2 //wheelchairs are not infact sport bikes

	if(has_buckled_mobs())
		var/mob/living/buckled_mob = buckled_mobs[1]
		if(buckled_mob.incapacitated())
			return 0

		var/mob/living/thedriver = user
		var/mob_delay = thedriver.cached_multiplicative_slowdown
		if(mob_delay > 0)
			calculated_move_delay += mob_delay

		if(ishuman(buckled_mob))
			var/mob/living/carbon/human/driver = user
			if(!driver.has_left_hand() && !driver.has_right_hand())
				return 0 // No hands to drive your chair? Tough luck!

			for(var/organ_name in list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_HAND))
				var/obj/item/organ/external/E = driver.get_organ(organ_name)
				if(!E)
					calculated_move_delay += 4
				else if(E.is_splinted())
					calculated_move_delay += 0.5
				else if(E.has_fracture())
					calculated_move_delay += 1.5

		if(calculated_move_delay < 4)
			calculated_move_delay = 4 //no racecarts
		glide_for(calculated_move_delay)
		if(direction & (direction - 1))	//moved diagonally
			calculated_move_delay *= 1.41

		move_delay = world.time
		move_delay += calculated_move_delay

		if(!buckled_mob.Move(get_step(buckled_mob, direction), direction))
			loc = buckled_mob.loc //we gotta go back
			last_move = buckled_mob.last_move
			inertia_dir = last_move
			buckled_mob.inertia_dir = last_move
			. = 0

		else
			. = 1

/obj/structure/chair/wheelchair/Bump(atom/A)
	..()

	if(!has_buckled_mobs())
		return
	var/mob/living/buckled_mob = buckled_mobs[1]
	if(istype(A, /obj/machinery/door))
		A.Bumped(buckled_mob)

	if(propelled)
		var/mob/living/occupant = buckled_mob
		unbuckle_mob(occupant)

		occupant.throw_at(A, 3, propelled)

		occupant.Weaken(12 SECONDS)
		occupant.Stuttering(12 SECONDS)
		playsound(src.loc, 'sound/weapons/punch1.ogg', 50, 1, -1)
		if(isliving(A))
			var/mob/living/victim = A
			victim.Weaken(12 SECONDS)
			victim.Stuttering(12 SECONDS)
			victim.take_organ_damage(10)

		occupant.visible_message("<span class='danger'>[occupant] crashed into \the [A]!</span>")

/obj/structure/chair/wheelchair/bike
	name = "bicycle"
	desc = "Two wheels of FURY!"
	//placeholder until i get a bike sprite
	icon = 'icons/obj/vehicles/motorcycle.dmi'
	icon_state = "motorcycle_4dir"

/obj/structure/chair/wheelchair/bike/relaymove(mob/user, direction)
	if(propelled)
		return 0

	if(!Process_Spacemove(direction) || !has_gravity(loc) || !isturf(loc))	//bikes in space.
		return 0

	if(world.time < move_delay)
		return

	var/calculated_move_delay
	calculated_move_delay = 0 //bikes are infact sport bikes

	if(has_buckled_mobs())
		var/mob/living/buckled_mob = buckled_mobs[1]
		if(buckled_mob.incapacitated())
			unbuckle_mob(buckled_mob)	//if the rider is incapacitated, unbuckle them (they can't balance so they fall off)
			return 0

		var/mob/living/thedriver = user
		var/mob_delay = thedriver.cached_multiplicative_slowdown
		if(mob_delay > 0)
			calculated_move_delay += mob_delay

		if(ishuman(buckled_mob))
			var/mob/living/carbon/human/driver = user
			var/obj/item/organ/external/l_hand = driver.get_organ(BODY_ZONE_PRECISE_L_HAND)
			var/obj/item/organ/external/r_hand = driver.get_organ(BODY_ZONE_PRECISE_R_HAND)
			if(!l_hand && !r_hand)
				calculated_move_delay += 0.5	//I can ride my bike with no handlebars... (but it's slower)

			for(var/organ_name in list(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_L_FOOT, BODY_ZONE_PRECISE_R_FOOT))
				var/obj/item/organ/external/E = driver.get_organ(organ_name)
				if(!E)
					return 0	//Bikes need both feet/legs to work. missing even one makes it so you can't ride the bike
				else if(E.is_splinted())
					calculated_move_delay += 0.5
				else if(E.has_fracture())
					calculated_move_delay += 1.5

		move_delay = world.time
		move_delay += calculated_move_delay

		if(!buckled_mob.Move(get_step(buckled_mob, direction), direction))
			loc = buckled_mob.loc //we gotta go back
			last_move = buckled_mob.last_move
			inertia_dir = last_move
			buckled_mob.inertia_dir = last_move
			. = 0

		else
			. = 1
