/obj/screen/human
	icon = 'icons/mob/screen_midnight.dmi'

/obj/screen/human/toggle
	name = "toggle"
	icon_state = "toggle"

/obj/screen/human/toggle/Click()
	if(usr.hud_used.inventory_shown)
		usr.hud_used.inventory_shown = FALSE
		usr.client.screen -= usr.hud_used.toggleable_inventory
	else
		usr.hud_used.inventory_shown = TRUE
		usr.client.screen += usr.hud_used.toggleable_inventory

	usr.hud_used.hidden_inventory_update()

/obj/screen/human/equip
	name = "equip"
	icon_state = "act_equip"

/obj/screen/human/equip/Click()
	if(ismecha(usr.loc)) // stops inventory actions in a mech
		return TRUE

	if(is_ventcrawling(usr)) // stops inventory actions in vents
		return TRUE

	var/mob/living/carbon/human/H = usr
	H.quick_equip()

/obj/screen/ling
	invisibility = INVISIBILITY_ABSTRACT

/obj/screen/ling/sting
	name = "current sting"
	screen_loc = ui_lingstingdisplay

/obj/screen/ling/sting/Click()
	var/datum/antagonist/changeling/cling = usr?.mind?.has_antag_datum(/datum/antagonist/changeling)
	cling?.chosen_sting?.unset_sting()

/obj/screen/ling/chems
	name = "chemical storage"
	icon_state = "power_display"
	screen_loc = ui_lingchemdisplay

/obj/screen/devil
	invisibility = INVISIBILITY_ABSTRACT

/obj/screen/devil/soul_counter
	icon = 'icons/mob/screen_gen.dmi'
	name = "souls owned"
	icon_state = "Devil-6"
	screen_loc = ui_devilsouldisplay

/obj/screen/devil/soul_counter/proc/update_counter(souls = 0)
	invisibility = 0
	maptext = "<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='#FF0000'>[souls]</font></div>"
	switch(souls)
		if(0,null)
			icon_state = "Devil-1"
		if(1,2)
			icon_state = "Devil-2"
		if(3 to 5)
			icon_state = "Devil-3"
		if(6 to 8)
			icon_state = "Devil-4"
		if(9 to INFINITY)
			icon_state = "Devil-5"
		else
			icon_state = "Devil-6"

/obj/screen/devil/soul_counter/proc/clear()
	invisibility = INVISIBILITY_ABSTRACT


/mob/living/carbon/human/create_mob_hud()
	if(client && !hud_used)
		hud_used = new /datum/hud/human(src, ui_style2icon(client.prefs.UI_style), client.prefs.UI_style_color, client.prefs.UI_style_alpha)

/datum/hud/human
	var/hud_alpha = 255

/datum/hud/human/New(mob/living/carbon/human/owner, var/ui_style = 'icons/mob/screen_white.dmi', var/ui_color = "#ffffff", var/ui_alpha = 255)
	..()
	owner.overlay_fullscreen("see_through_darkness", /obj/screen/fullscreen/see_through_darkness)
	var/obj/screen/using
	var/obj/screen/inventory/inv_box

	hud_alpha = ui_alpha

	using = new /obj/screen/craft
	using.icon = ui_style
	using.color = ui_color
	using.alpha = ui_alpha
	static_inventory += using

	using = new /obj/screen/language_menu
	using.icon = ui_style
	using.color = ui_color
	using.alpha = ui_alpha
	static_inventory += using

	using = new /obj/screen/act_intent()
	using.icon_state = mymob.a_intent
	using.alpha = ui_alpha
	static_inventory += using
	action_intent = using

	using = new /obj/screen/mov_intent()
	using.icon = ui_style
	using.icon_state = (mymob.m_intent == MOVE_INTENT_RUN ? "running" : "walking")
	using.screen_loc = ui_movi
	using.color = ui_color
	using.alpha = ui_alpha
	static_inventory += using
	move_intent = using

	using = new /obj/screen/drop()
	using.icon = ui_style
	using.screen_loc = ui_drop_throw
	using.color = ui_color
	using.alpha = ui_alpha
	static_inventory += using

	inv_box = new /obj/screen/inventory()
	inv_box.name = "i_clothing"
	inv_box.icon = ui_style
	inv_box.slot_id = ITEM_SLOT_CLOTH_INNER
	inv_box.icon_state = "uniform"
	inv_box.screen_loc = ui_iclothing
	inv_box.color = ui_color
	inv_box.alpha = ui_alpha
	toggleable_inventory += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "o_clothing"
	inv_box.icon = ui_style
	inv_box.slot_id = ITEM_SLOT_CLOTH_OUTER
	inv_box.icon_state = "suit"
	inv_box.screen_loc = ui_oclothing
	inv_box.color = ui_color
	inv_box.alpha = ui_alpha
	toggleable_inventory += inv_box

	inv_box = new /obj/screen/inventory/hand()
	inv_box.name = "r_hand"
	inv_box.icon = ui_style
	inv_box.icon_state = "hand_r"
	inv_box.color = ui_color
	inv_box.alpha = ui_alpha
	inv_box.screen_loc = ui_rhand
	inv_box.slot_id = ITEM_SLOT_HAND_RIGHT
	static_inventory += inv_box
	hand_slots += inv_box

	inv_box = new /obj/screen/inventory/hand()
	inv_box.name = "l_hand"
	inv_box.icon = ui_style
	inv_box.icon_state = "hand_l"
	inv_box.color = ui_color
	inv_box.alpha = ui_alpha
	inv_box.screen_loc = ui_lhand
	inv_box.slot_id = ITEM_SLOT_HAND_LEFT
	static_inventory += inv_box
	hand_slots += inv_box

	using = new /obj/screen/swap_hand()
	using.name = "hand"
	using.icon = ui_style
	using.icon_state = "swap_1"
	using.screen_loc = ui_swaphand1
	using.color = ui_color
	using.alpha = ui_alpha
	static_inventory += using

	using = new /obj/screen/swap_hand()
	using.name = "hand"
	using.icon = ui_style
	using.icon_state = "swap_2"
	using.screen_loc = ui_swaphand2
	using.color = ui_color
	using.alpha = ui_alpha
	static_inventory += using

	inv_box = new /obj/screen/inventory()
	inv_box.name = "id"
	inv_box.icon = ui_style
	inv_box.icon_state = "id"
	inv_box.screen_loc = ui_id
	inv_box.slot_id = ITEM_SLOT_ID
	inv_box.color = ui_color
	inv_box.alpha = ui_alpha
	static_inventory += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "pda"
	inv_box.icon = ui_style
	inv_box.icon_state = "pda"
	inv_box.screen_loc = ui_pda
	inv_box.slot_id = ITEM_SLOT_PDA
	inv_box.color = ui_color
	inv_box.alpha = ui_alpha
	static_inventory += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "mask"
	inv_box.icon = ui_style
	inv_box.icon_state = "mask"
	inv_box.screen_loc = ui_mask
	inv_box.slot_id = ITEM_SLOT_MASK
	inv_box.color = ui_color
	inv_box.alpha = ui_alpha
	toggleable_inventory += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "neck"
	inv_box.icon = ui_style
	inv_box.icon_state = "neck"
	inv_box.screen_loc = ui_neck
	inv_box.slot_id = ITEM_SLOT_NECK
	inv_box.color = ui_color
	inv_box.alpha = ui_alpha
	toggleable_inventory += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "back"
	inv_box.icon = ui_style
	inv_box.icon_state = "back"
	inv_box.screen_loc = ui_back
	inv_box.slot_id = ITEM_SLOT_BACK
	inv_box.color = ui_color
	inv_box.alpha = ui_alpha
	static_inventory += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "storage1"
	inv_box.icon = ui_style
	inv_box.icon_state = "pocket"
	inv_box.screen_loc = ui_storage1
	inv_box.slot_id = ITEM_SLOT_POCKET_LEFT
	inv_box.color = ui_color
	inv_box.alpha = ui_alpha
	static_inventory += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "storage2"
	inv_box.icon = ui_style
	inv_box.icon_state = "pocket"
	inv_box.screen_loc = ui_storage2
	inv_box.slot_id = ITEM_SLOT_POCKET_RIGHT
	inv_box.color = ui_color
	inv_box.alpha = ui_alpha
	static_inventory += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "suit storage"
	inv_box.icon = ui_style
	inv_box.icon_state = "suit_storage"
	inv_box.color = ui_color
	inv_box.alpha = ui_alpha
	inv_box.screen_loc = ui_sstore1
	inv_box.slot_id = ITEM_SLOT_SUITSTORE
	static_inventory += inv_box

	using = new /obj/screen/resist()
	using.icon = ui_style
	using.color = ui_color
	using.alpha = ui_alpha
	using.screen_loc = ui_pull_resist
	hotkeybuttons += using

	using = new /obj/screen/human/toggle()
	using.icon = ui_style
	using.color = ui_color
	using.alpha = ui_alpha
	using.screen_loc = ui_inventory
	static_inventory += using

	using = new /obj/screen/human/equip()
	using.icon = ui_style
	using.color = ui_color
	using.alpha = ui_alpha
	using.screen_loc = ui_equip
	static_inventory += using

	inv_box = new /obj/screen/inventory()
	inv_box.name = "gloves"
	inv_box.icon = ui_style
	inv_box.icon_state = "gloves"
	inv_box.screen_loc = ui_gloves
	inv_box.slot_id = ITEM_SLOT_GLOVES
	inv_box.color = ui_color
	inv_box.alpha = ui_alpha
	toggleable_inventory += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "eyes"
	inv_box.icon = ui_style
	inv_box.icon_state = "glasses"
	inv_box.screen_loc = ui_glasses
	inv_box.slot_id = ITEM_SLOT_EYES
	inv_box.color = ui_color
	inv_box.alpha = ui_alpha
	toggleable_inventory += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "l_ear"
	inv_box.icon = ui_style
	inv_box.icon_state = "ears"
	inv_box.screen_loc = ui_l_ear
	inv_box.slot_id = ITEM_SLOT_EAR_LEFT
	inv_box.color = ui_color
	inv_box.alpha = ui_alpha
	toggleable_inventory += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "r_ear"
	inv_box.icon = ui_style
	inv_box.icon_state = "ears"
	inv_box.screen_loc = ui_r_ear
	inv_box.slot_id = ITEM_SLOT_EAR_RIGHT
	inv_box.color = ui_color
	inv_box.alpha = ui_alpha
	toggleable_inventory += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "head"
	inv_box.icon = ui_style
	inv_box.icon_state = "head"
	inv_box.screen_loc = ui_head
	inv_box.slot_id = ITEM_SLOT_HEAD
	inv_box.color = ui_color
	inv_box.alpha = ui_alpha
	toggleable_inventory += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "shoes"
	inv_box.icon = ui_style
	inv_box.icon_state = "shoes"
	inv_box.screen_loc = ui_shoes
	inv_box.slot_id = ITEM_SLOT_FEET
	inv_box.color = ui_color
	inv_box.alpha = ui_alpha
	toggleable_inventory += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "belt"
	inv_box.icon = ui_style
	inv_box.icon_state = "belt"
	inv_box.screen_loc = ui_belt
	inv_box.slot_id = ITEM_SLOT_BELT
	inv_box.color = ui_color
	inv_box.alpha = ui_alpha
	static_inventory += inv_box

	mymob.throw_icon = new /obj/screen/throw_catch()
	mymob.throw_icon.icon = ui_style
	mymob.throw_icon.screen_loc = ui_drop_throw
	mymob.throw_icon.color = ui_color
	mymob.throw_icon.alpha = ui_alpha
	hotkeybuttons += mymob.throw_icon

	mymob.healths = new /obj/screen/healths()
	infodisplay += mymob.healths

	mymob.healthdoll = new()
	infodisplay += mymob.healthdoll

	mymob.pullin = new /obj/screen/pull()
	mymob.pullin.hud = src
	mymob.pullin.icon = ui_style
	mymob.pullin.update_icon(UPDATE_ICON_STATE)
	mymob.pullin.screen_loc = ui_pull_resist
	static_inventory += mymob.pullin

	mymob.stamina_bar = new /obj/screen/stamina_bar()
	infodisplay += mymob.stamina_bar

	lingchemdisplay = new /obj/screen/ling/chems()
	infodisplay += lingchemdisplay

	lingstingdisplay = new /obj/screen/ling/sting()
	infodisplay += lingstingdisplay

	devilsouldisplay = new /obj/screen/devil/soul_counter
	infodisplay += devilsouldisplay

	zone_select =  new /obj/screen/zone_sel(null, src, ui_style, ui_alpha, ui_color)
	static_inventory += zone_select

	inventory_shown = FALSE

	combo_display = new()
	infodisplay += combo_display


	for(var/obj/screen/inventory/inv in (static_inventory + toggleable_inventory))
		if(inv.slot_id)
			inv.hud = src
			inv_slots[TOBITSHIFT(inv.slot_id) + 1] = inv
			inv.update_appearance()

	update_locked_slots()


/datum/hud/human/update_locked_slots()
	if(!mymob)
		return
	var/mob/living/carbon/human/H = mymob
	if(!istype(H) || !H.dna.species)
		return
	var/datum/species/S = H.dna.species
	for(var/obj/screen/inventory/inv in (static_inventory + toggleable_inventory))
		if(inv.slot_id)
			if(inv.slot_id in S.no_equip)
				inv.alpha = hud_alpha / 2
			else
				inv.alpha = hud_alpha
	for(var/obj/screen/craft/crafting in static_inventory)
		if(!S.can_craft)
			crafting.invisibility = INVISIBILITY_ABSTRACT
			H.handcrafting.close(H)
		else
			crafting.invisibility = initial(crafting.invisibility)

/datum/hud/human/hidden_inventory_update()
	if(!mymob?.client)
		return
	var/mob/living/carbon/human/H = mymob
	if(inventory_shown && hud_shown)
		if(H.shoes)
			H.shoes.screen_loc = ui_shoes
			H.client.screen += H.shoes
		if(H.gloves)
			H.gloves.screen_loc = ui_gloves
			H.client.screen += H.gloves
		if(H.l_ear)
			H.l_ear.screen_loc = ui_l_ear
			H.client.screen += H.l_ear
		if(H.r_ear)
			H.r_ear.screen_loc = ui_r_ear
			H.client.screen += H.r_ear
		if(H.glasses)
			H.glasses.screen_loc = ui_glasses
			H.client.screen += H.glasses
		if(H.w_uniform)
			H.w_uniform.screen_loc = ui_iclothing
			H.client.screen += H.w_uniform
		if(H.wear_suit)
			H.wear_suit.screen_loc = ui_oclothing
			H.client.screen += H.wear_suit
		if(H.wear_mask)
			H.wear_mask.screen_loc = ui_mask
			H.client.screen += H.wear_mask
		if(H.neck)
			H.neck.screen_loc = ui_neck
			H.client.screen += H.neck
		if(H.head)
			H.head.screen_loc = ui_head
			H.client.screen += H.head
	else
		H.shoes?.screen_loc = null
		H.gloves?.screen_loc = null
		H.l_ear?.screen_loc = null
		H.r_ear?.screen_loc = null
		H.glasses?.screen_loc = null
		H.w_uniform?.screen_loc = null
		H.wear_suit?.screen_loc = null
		H.wear_mask?.screen_loc = null
		H.neck?.screen_loc = null
		H.head?.screen_loc = null

/datum/hud/human/persistent_inventory_update()
	if(!mymob)
		return
	var/mob/living/carbon/human/H = mymob
	if(hud_shown)
		if(H.s_store)
			H.s_store.screen_loc = ui_sstore1
			H.client.screen += H.s_store
		if(H.wear_id)
			H.wear_id.screen_loc = ui_id
			H.client.screen += H.wear_id
		if(H.wear_pda)
			H.wear_pda.screen_loc = ui_pda
			H.client.screen += H.wear_pda
		if(H.belt)
			H.belt.screen_loc = ui_belt
			H.client.screen += H.belt
		if(H.back)
			H.back.screen_loc = ui_back
			H.client.screen += H.back
		if(H.l_store)
			H.l_store.screen_loc = ui_storage1
			H.client.screen += H.l_store
		if(H.r_store)
			H.r_store.screen_loc = ui_storage2
			H.client.screen += H.r_store
	else
		if(H.s_store)
			H.s_store.screen_loc = null
		if(H.wear_id)
			H.wear_id.screen_loc = null
		if(H.wear_pda)
			H.wear_pda.screen_loc = null
		if(H.belt)
			H.belt.screen_loc = null
		if(H.back)
			H.back.screen_loc = null
		if(H.l_store)
			H.l_store.screen_loc = null
		if(H.r_store)
			H.r_store.screen_loc = null

	if(hud_version != HUD_STYLE_NOHUD)
		if(H.r_hand)
			H.r_hand.screen_loc = ui_rhand
			H.client.screen += H.r_hand
		if(H.l_hand)
			H.l_hand.screen_loc = ui_lhand
			H.client.screen += H.l_hand
	else
		if(H.r_hand)
			H.r_hand.screen_loc = null
		if(H.l_hand)
			H.l_hand.screen_loc = null


/mob/living/carbon/human/verb/toggle_hotkey_verbs()
	set category = "OOC"
	set name = "Toggle Hotkey Buttons"
	set desc = "This disables or enables the user interface buttons which can be used with hotkeys."

	if(hud_used.hotkey_ui_hidden)
		client.screen += hud_used.hotkeybuttons
		hud_used.hotkey_ui_hidden = FALSE
	else
		client.screen -= hud_used.hotkeybuttons
		hud_used.hotkey_ui_hidden = TRUE
