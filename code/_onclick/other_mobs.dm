/*
	Humans:
	Adds an exception for gloves, to allow special glove types like the ninja ones.

	Otherwise pretty standard.
*/
/mob/living/carbon/human/UnarmedAttack(atom/A, proximity)
	// Special glove functions:
	// If the gloves do anything, have them return 1 to stop
	// normal attack_hand() here.
	var/obj/item/clothing/gloves/G = gloves // not typecast specifically enough in defines
	if(proximity && istype(G) && G.Touch(A, 1))
		return


	if(buckled && isstructure(buckled))
		var/obj/structure/S = buckled
		if(S.prevents_buckled_mobs_attacking())
			return

	A.attack_hand(src)


/mob/living/carbon/human/beforeAdjacentClick(atom/A, params)
	if(prob(dna.species.fragile_bones_chance * 3))
		var/zone = "[hand ? "l" : "r"]_[pick("hand", "arm")]"
		var/obj/item/organ/external/active_hand = get_organ(zone)
		if(!active_hand.has_fracture())
			var/used_item_name = get_active_hand()
			to_chat(src, span_danger("[used_item_name? "You try to use [used_item_name], but y": "Y"]our [active_hand] don't withstand the load!"))
			active_hand.fracture()


/atom/proc/attack_hand(mob/user)
	if(SEND_SIGNAL(src, COMSIG_ATOM_ATTACK_HAND, user) & COMPONENT_CANCEL_ATTACK_CHAIN)
		return TRUE

/*
/mob/living/carbon/human/RestrainedClickOn(var/atom/A) -- Handled by carbons
	return
*/

/mob/living/carbon/RestrainedClickOn(var/atom/A)
	return 0

/mob/living/carbon/human/RangedAttack(atom/A, params)
	. = ..()
	if(gloves)
		var/obj/item/clothing/gloves/G = gloves
		if(istype(G) && G.Touch(A, 0)) // for magic gloves
			return

	if(!GLOB.pacifism_after_gt)
		if(HAS_TRAIT(src, TRAIT_LASEREYES) && a_intent == INTENT_HARM)
			LaserEyes(A)

		if(TK in mutations)
			A.attack_tk(src)

	if(isturf(A) && get_dist(src, A) <= 1)
		Move_Pulled(A)

/*
	Animals & All Unspecified
*/
/mob/living/UnarmedAttack(var/atom/A)
	A.attack_animal(src)

/mob/living/simple_animal/hostile/UnarmedAttack(var/atom/A)
	target = A
	AttackingTarget()

/atom/proc/attack_animal(mob/user)
	return

/mob/living/RestrainedClickOn(var/atom/A)
	return

/*
	Aliens
	Defaults to same as monkey in most places
*/
/mob/living/carbon/alien/UnarmedAttack(atom/A)
	A.attack_alien(src)

/atom/proc/attack_alien(mob/living/carbon/alien/user)
	attack_hand(user)

/mob/living/carbon/alien/RestrainedClickOn(atom/A)
	return

// Babby aliens
/mob/living/carbon/alien/larva/UnarmedAttack(atom/A)
	A.attack_larva(src)

/atom/proc/attack_larva(mob/user)
	return

/*
	Slimes
	Nothing happening here
*/
/mob/living/simple_animal/slime/UnarmedAttack(atom/A)
	A.attack_slime(src)

/atom/proc/attack_slime(mob/user)
	return

/mob/living/simple_animal/slime/RestrainedClickOn(atom/A)
	return

/*
	New Players:
	Have no reason to click on anything at all.
*/
/mob/new_player/ClickOn()
	return

// pAIs are not intended to interact with anything in the world
/mob/living/silicon/pai/UnarmedAttack(var/atom/A)
	return
