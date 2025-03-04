//Cargo
/datum/job/qm
	title = JOB_TITLE_QUARTERMASTER
	flag = JOB_FLAG_QUARTERMASTER
	department_flag = JOBCAT_SUPPORT
	total_positions = 1
	spawn_positions = 1
	is_supply = 1
	supervisors = "the captain"
	department_head = list(JOB_TITLE_CAPTAIN)
	selection_color = "#9f8545"
	access = list(ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_HEADS_VAULT, ACCESS_ALL_PERSONAL_LOCKERS, ACCESS_HEADS, ACCESS_SEC_DOORS, ACCESS_EVA, ACCESS_MAINT_TUNNELS, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_CARGO_BOT, ACCESS_QM, ACCESS_MINT, ACCESS_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_HEADS_VAULT, ACCESS_ALL_PERSONAL_LOCKERS, ACCESS_HEADS, ACCESS_SECURITY, ACCESS_EVA, ACCESS_MAINT_TUNNELS, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_CARGO_BOT, ACCESS_QM, ACCESS_MINT, ACCESS_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM)
	min_age_allowed = 30
	exp_requirements = 3000
	exp_type = EXP_TYPE_CREW
	money_factor = 6
	outfit = /datum/outfit/job/qm

/datum/outfit/job/qm
	name = "Quartermaster"
	jobtype = /datum/job/qm

	uniform = /obj/item/clothing/under/rank/cargo
	shoes = /obj/item/clothing/shoes/brown
	l_ear = /obj/item/radio/headset/heads/qm
	glasses = /obj/item/clothing/glasses/sunglasses
	l_pocket = /obj/item/lighter/zippo/qm
	id = /obj/item/card/id/qm
	l_hand = /obj/item/clipboard
	pda = /obj/item/pda/quartermaster
	backpack = /obj/item/storage/backpack/cargo
	backpack_contents = list(
	/obj/item/melee/classic_baton/telescopic = 1
	)
	head = /obj/item/clothing/head/cowboyhat/tan


/datum/job/cargo_tech
	title = JOB_TITLE_CARGOTECH
	flag = JOB_FLAG_CARGOTECH
	department_flag = JOBCAT_SUPPORT
	total_positions = 2
	spawn_positions = 2
	is_supply = 1
	supervisors = "the quartermaster"
	department_head = list(JOB_TITLE_QUARTERMASTER)
	selection_color = "#e2dbc8"
	access = list(ACCESS_MAINT_TUNNELS, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_CARGO_BOT, ACCESS_MINT, ACCESS_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_MAINT_TUNNELS, ACCESS_CARGO, ACCESS_CARGO_BOT, ACCESS_MAILSORTING, ACCESS_MINERAL_STOREROOM)
	money_factor = 2
	outfit = /datum/outfit/job/cargo_tech

/datum/outfit/job/cargo_tech
	name = "Cargo Technician"
	jobtype = /datum/job/cargo_tech

	uniform = /obj/item/clothing/under/rank/cargotech
	shoes = /obj/item/clothing/shoes/black
	l_ear = /obj/item/radio/headset/headset_cargo
	id = /obj/item/card/id/supply
	pda = /obj/item/pda/cargo
	backpack = /obj/item/storage/backpack/cargo


/datum/job/mining
	title = JOB_TITLE_MINER
	flag = JOB_FLAG_MINER
	department_flag = JOBCAT_SUPPORT
	total_positions = 6
	spawn_positions = 8
	is_supply = 1
	supervisors = "the quartermaster"
	department_head = list(JOB_TITLE_QUARTERMASTER)
	selection_color = "#e2dbc8"
	access = list(ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_CARGO_BOT, ACCESS_MINT, ACCESS_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_MINING, ACCESS_MINT, ACCESS_MINING_STATION, ACCESS_MAILSORTING, ACCESS_MAINT_TUNNELS, ACCESS_MINERAL_STOREROOM)
	alt_titles = list("Spelunker")
	money_factor = 3
	outfit = /datum/outfit/job/mining

/datum/outfit/job/mining
	name = "Shaft Miner"
	jobtype = /datum/job/mining

	l_ear = /obj/item/radio/headset/headset_cargo/mining
	shoes = /obj/item/clothing/shoes/workboots/mining
	gloves = /obj/item/clothing/gloves/color/black
	uniform = /obj/item/clothing/under/rank/miner/lavaland
	l_pocket = /obj/item/reagent_containers/hypospray/autoinjector/survival
	r_pocket = /obj/item/storage/bag/ore
	id = /obj/item/card/id/supply
	pda = /obj/item/pda/shaftminer
	backpack_contents = list(
		/obj/item/flashlight/seclite = 1,
		/obj/item/kitchen/knife/combat/survival = 1,
		/obj/item/mining_voucher = 1,
		/obj/item/stack/marker_beacon/ten = 1,
		/obj/item/wormhole_jaunter = 1,
		/obj/item/survivalcapsule = 1
	)

	backpack = /obj/item/storage/backpack/explorer
	satchel = /obj/item/storage/backpack/satchel_explorer
	box = /obj/item/storage/box/survival_mining

/datum/outfit/job/mining/equipped
	name = "Shaft Miner"
	toggle_helmet = TRUE
	suit = /obj/item/clothing/suit/hooded/explorer
	mask = /obj/item/clothing/mask/gas/explorer
	glasses = /obj/item/clothing/glasses/meson
	suit_store = /obj/item/tank/internals/emergency_oxygen
	internals_slot = ITEM_SLOT_SUITSTORE
	backpack_contents = list(
		/obj/item/flashlight/seclite = 1,
		/obj/item/kitchen/knife/combat/survival = 1,
		/obj/item/mining_voucher = 1,
		/obj/item/t_scanner/adv_mining_scanner/lesser = 1,
		/obj/item/gun/energy/kinetic_accelerator = 1,
		/obj/item/stack/marker_beacon/ten = 1
	)

/datum/outfit/job/miner/equipped/hardsuit
	name = "Shaft Miner (Equipment + Hardsuit)"
	suit = /obj/item/clothing/suit/space/hardsuit/mining
	mask = /obj/item/clothing/mask/breath

//Food
/datum/job/bartender
	title = JOB_TITLE_BARTENDER
	flag = JOB_FLAG_BARTENDER
	department_flag = JOBCAT_SUPPORT
	total_positions = 1
	spawn_positions = 1
	is_service = 1
	supervisors = "the head of personnel"
	department_head = list(JOB_TITLE_HOP)
	selection_color = "#d1e8d3"
	access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_BAR, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM)
	alt_titles = list("Barman","Barkeeper","Drink Artist")
	money_factor = 2
	outfit = /datum/outfit/job/bartender

/datum/outfit/job/bartender
	name = "Bartender"
	jobtype = /datum/job/bartender

	uniform = /obj/item/clothing/under/rank/bartender
	suit = /obj/item/clothing/suit/armor/vest
	belt = /obj/item/storage/belt/bandolier/full
	shoes = /obj/item/clothing/shoes/black
	l_ear = /obj/item/radio/headset/headset_service
	glasses = /obj/item/clothing/glasses/sunglasses/reagent
	pda = /obj/item/pda/bar
	backpack_contents = list(
		/obj/item/toy/russian_revolver = 1
	)

/datum/outfit/job/bartender/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(visualsOnly)
		return

	H.dna.SetSEState(GLOB.soberblock,1)
	genemutcheck(H, GLOB.soberblock, null, MUTCHK_FORCED)
	H.dna.default_blocks.Add(GLOB.soberblock)
	H.check_mutations = 1



/datum/job/chef
	title = JOB_TITLE_CHEF
	flag = JOB_FLAG_CHEF
	department_flag = JOBCAT_SUPPORT
	total_positions = 1
	spawn_positions = 1
	is_service = 1
	supervisors = "the head of personnel"
	department_head = list(JOB_TITLE_HOP)
	selection_color = "#d1e8d3"
	access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE)
	minimal_access = list(ACCESS_KITCHEN)
	alt_titles = list("Cook","Culinary Artist","Butcher")
	money_factor = 2
	outfit = /datum/outfit/job/chef

/datum/outfit/job/chef
	name = "Chef"
	jobtype = /datum/job/chef

	uniform = /obj/item/clothing/under/rank/chef
	suit = /obj/item/clothing/suit/chef
	belt = /obj/item/storage/belt/chef
	shoes = /obj/item/clothing/shoes/black
	head = /obj/item/clothing/head/chefhat
	l_ear = /obj/item/radio/headset/headset_service
	pda = /obj/item/pda/chef
	backpack_contents = list(
		/obj/item/paper/chef=1,\
		/obj/item/book/manual/chef_recipes=1)

/datum/outfit/job/chef/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	var/datum/martial_art/cqc/under_siege/justacook = new
	justacook.teach(H)

/datum/outfit/job/chef/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(H.mind && H.mind.role_alt_title)
		switch(H.mind.role_alt_title)
			if("Culinary Artist")
				uniform = /obj/item/clothing/under/artist
				belt = /obj/item/storage/belt/chef/artistred
				head = /obj/item/clothing/head/chefcap
				suit = /obj/item/clothing/suit/storage/chefbluza


/datum/job/hydro
	title = JOB_TITLE_BOTANIST
	flag = JOB_FLAG_BOTANIST
	department_flag = JOBCAT_SUPPORT
	total_positions = 2
	spawn_positions = 2
	is_service = 1
	supervisors = "the head of personnel"
	department_head = list(JOB_TITLE_HOP)
	selection_color = "#d1e8d3"
	access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE)
	minimal_access = list(ACCESS_HYDROPONICS, ACCESS_MORGUE)
	alt_titles = list("Hydroponicist", "Botanical Researcher")
	exp_requirements = 300
	exp_type = EXP_TYPE_CREW
	money_factor = 2
	outfit = /datum/outfit/job/hydro

/datum/outfit/job/hydro
	name = "Botanist"
	jobtype = /datum/job/hydro

	uniform = /obj/item/clothing/under/rank/hydroponics
	suit = /obj/item/clothing/suit/apron
	gloves = /obj/item/clothing/gloves/botanic_leather
	shoes = /obj/item/clothing/shoes/black
	l_ear = /obj/item/radio/headset/headset_service
	suit_store = /obj/item/plant_analyzer
	pda = /obj/item/pda/botanist

	backpack = /obj/item/storage/backpack/botany
	satchel = /obj/item/storage/backpack/satchel_hyd
	dufflebag = /obj/item/storage/backpack/duffel/hydro

//Griff //BS12 EDIT

/datum/job/clown
	title = JOB_TITLE_CLOWN
	flag = JOB_FLAG_CLOWN
	department_flag = JOBCAT_SUPPORT
	total_positions = 1
	spawn_positions = 1
	is_service = 1
	supervisors = "the head of personnel"
	department_head = list(JOB_TITLE_HOP)
	selection_color = "#d1e8d3"
	access = list(ACCESS_CLOWN, ACCESS_THEATRE)
	minimal_access = list(ACCESS_CLOWN, ACCESS_THEATRE)
	alt_titles = list("Performance Artist","Comedian","Jester")
	money_factor = 2
	outfit = /datum/outfit/job/clown

/datum/outfit/job/clown
	name = "Clown"
	jobtype = /datum/job/clown

	uniform = /obj/item/clothing/under/rank/clown
	belt = /obj/item/signmaker
	shoes = /obj/item/clothing/shoes/clown_shoes
	mask = /obj/item/clothing/mask/gas/clown_hat
	l_pocket = /obj/item/bikehorn
	l_ear = /obj/item/radio/headset/headset_service
	id = /obj/item/card/id/clown
	pda = /obj/item/pda/clown
	backpack_contents = list(
		/obj/item/reagent_containers/food/snacks/grown/banana = 1,
		/obj/item/stamp/clown = 1,
		/obj/item/toy/crayon/rainbow = 1,
		/obj/item/storage/fancy/crayons = 1,
		/obj/item/reagent_containers/spray/waterflower = 1,
		/obj/item/reagent_containers/food/drinks/bottle/bottleofbanana = 1,
		/obj/item/instrument/bikehorn = 1,
		/obj/item/clown_recorder = 1
	)

	implants = list(/obj/item/implant/sad_trombone)

	backpack = /obj/item/storage/backpack/clown
	satchel = /obj/item/storage/backpack/satchel_clown
	dufflebag = /obj/item/storage/backpack/duffel/clown

/datum/outfit/job/clown/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(H.gender == FEMALE)
		mask = /obj/item/clothing/mask/gas/clown_hat/sexy
		uniform = /obj/item/clothing/under/rank/clown/sexy

/datum/outfit/job/clown/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(visualsOnly)
		return

	if(ismachineperson(H))
		var/obj/item/organ/internal/cyberimp/brain/clown_voice/implant = new
		implant.insert(H)

	H.dna.SetSEState(GLOB.clumsyblock, TRUE)
	genemutcheck(H, GLOB.clumsyblock, null, MUTCHK_FORCED)
	H.dna.default_blocks.Add(GLOB.clumsyblock)
	if(!ismachineperson(H))
		H.dna.SetSEState(GLOB.comicblock, TRUE)
		genemutcheck(H, GLOB.comicblock, null, MUTCHK_FORCED)
		H.dna.default_blocks.Add(GLOB.comicblock)
	H.check_mutations = TRUE
	H.add_language(LANGUAGE_CLOWN)

//action given to antag clowns
/datum/action/innate/toggle_clumsy
	name = "Toggle Clown Clumsy"
	button_icon_state = "clown"

/datum/action/innate/toggle_clumsy/Activate()
	var/mob/living/carbon/human/H = owner
	H.mutations.Add(CLUMSY)
	active = TRUE
	background_icon_state = "bg_spell"
	UpdateButtonIcon()
	to_chat(H, "<span class='notice'>You start acting clumsy to throw suspicions off. Focus again before using weapons.</span>")

/datum/action/innate/toggle_clumsy/Deactivate()
	var/mob/living/carbon/human/H = owner
	H.mutations.Remove(CLUMSY)
	active = FALSE
	background_icon_state = "bg_default"
	UpdateButtonIcon()
	to_chat(H, "<span class='notice'>You focus and can now use weapons regularly.</span>")

/datum/job/mime
	title = JOB_TITLE_MIME
	flag = JOB_FLAG_MIME
	department_flag = JOBCAT_SUPPORT
	total_positions = 1
	spawn_positions = 1
	is_service = 1
	supervisors = "the head of personnel"
	department_head = list(JOB_TITLE_HOP)
	selection_color = "#d1e8d3"
	access = list(ACCESS_MIME, ACCESS_THEATRE)
	minimal_access = list(ACCESS_MIME, ACCESS_THEATRE)
	alt_titles = list("Panthomimist")
	money_factor = 2
	outfit = /datum/outfit/job/mime

/datum/outfit/job/mime
	name = "Mime"
	jobtype = /datum/job/mime

	uniform = /obj/item/clothing/under/mime
	suit = /obj/item/clothing/suit/suspenders
	gloves = /obj/item/clothing/gloves/color/white
	shoes = /obj/item/clothing/shoes/black
	head = /obj/item/clothing/head/beret
	mask = /obj/item/clothing/mask/gas/mime
	l_ear = /obj/item/radio/headset/headset_service
	id = /obj/item/card/id/mime
	pda = /obj/item/pda/mime
	backpack_contents = list(
		/obj/item/toy/crayon/mime = 1,
		/obj/item/reagent_containers/food/drinks/bottle/bottleofnothing = 1,
		/obj/item/cane = 1
	)
	backpack = /obj/item/storage/backpack/mime
	satchel = /obj/item/storage/backpack/satchel_mime

/datum/outfit/job/mime/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/mimeskirt
		mask = /obj/item/clothing/mask/gas/mime/sexy

/datum/outfit/job/mime/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(visualsOnly)
		return

	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/aoe/conjure/build/mime_wall(null))
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/mime/speak(null))
		H.mind.miming = TRUE



/datum/job/janitor
	title = JOB_TITLE_JANITOR
	flag = JOB_FLAG_JANITOR
	department_flag = JOBCAT_SUPPORT
	total_positions = 1
	spawn_positions = 1
	is_service = 1
	supervisors = "the head of personnel"
	department_head = list(JOB_TITLE_HOP)
	selection_color = "#d1e8d3"
	access = list(ACCESS_JANITOR, ACCESS_MAINT_TUNNELS)
	minimal_access = list(ACCESS_JANITOR, ACCESS_MAINT_TUNNELS)
	alt_titles = list("Custodial Technician","Sanitation Technician")
	money_factor = 2
	outfit = /datum/outfit/job/janitor

/datum/outfit/job/janitor
	name = "Janitor"
	jobtype = /datum/job/janitor

	uniform = /obj/item/clothing/under/rank/janitor
	shoes = /obj/item/clothing/shoes/black
	l_ear = /obj/item/radio/headset/headset_service
	pda = /obj/item/pda/janitor


//More or less assistants
/datum/job/librarian
	title = JOB_TITLE_LIBRARIAN
	flag = JOB_FLAG_LIBRARIAN
	department_flag = JOBCAT_SUPPORT
	total_positions = 1
	spawn_positions = 1
	is_service = 1
	supervisors = "the head of personnel"
	department_head = list(JOB_TITLE_HOP)
	selection_color = "#d1e8d3"
	access = list(ACCESS_LIBRARY)
	minimal_access = list(ACCESS_LIBRARY)
	alt_titles = list("Journalist")
	money_factor = 2
	outfit = /datum/outfit/job/librarian

/datum/outfit/job/librarian
	name = "Librarian"
	jobtype = /datum/job/librarian

	uniform = /obj/item/clothing/under/suit_jacket/red
	shoes = /obj/item/clothing/shoes/black
	l_ear = /obj/item/radio/headset/headset_service
	l_pocket = /obj/item/laser_pointer
	r_pocket = /obj/item/barcodescanner
	l_hand = /obj/item/storage/bag/books
	pda = /obj/item/pda/librarian
	backpack_contents = list(
		/obj/item/videocam = 1)

/datum/job/barber
	title = JOB_TITLE_BARBER
	flag = JOB_FLAG_BARBER
	department_flag = JOBCAT_KARMA
	total_positions = 1
	spawn_positions = 1
	is_service = 1
	supervisors = "the head of personnel"
	department_head = list(JOB_TITLE_HOP)
	selection_color = "#d1e8d3"
	alt_titles = list("Hair Stylist","Beautician")
	access = list()
	minimal_access = list()
	money_factor = 2
	outfit = /datum/outfit/job/barber

/datum/outfit/job/barber
	name = "Barber"
	jobtype = /datum/job/barber

	uniform = /obj/item/clothing/under/barber
	shoes = /obj/item/clothing/shoes/black
	l_ear = /obj/item/radio/headset/headset_service
	backpack_contents = list(
		/obj/item/storage/box/lip_stick = 1,
		/obj/item/storage/box/barber = 1
	)

/datum/job/explorer
	title = JOB_TITLE_EXPLORER
	flag = JOB_FLAG_EXPLORER
	department_flag = JOBCAT_SUPPORT
	total_positions = 0
	spawn_positions = 0
	supervisors = "the head of personnel"
	department_head = list(JOB_TITLE_HOP)
	selection_color = "#d1e8d3"
	access = list(ACCESS_MAINT_TUNNELS, ACCESS_GATEWAY, ACCESS_EVA, ACCESS_EXTERNAL_AIRLOCKS)
	minimal_access = list(ACCESS_MAINT_TUNNELS, ACCESS_GATEWAY, ACCESS_EVA, ACCESS_EXTERNAL_AIRLOCKS)
	outfit = /datum/outfit/job/explorer
	hidden_from_job_prefs = TRUE

/datum/outfit/job/explorer
	// This outfit is never used, because there are no slots for this job.
	// To get it, you have to go to the HOP and ask for a transfer to it.
	name = "Explorer"
	jobtype = /datum/job/explorer
	uniform = /obj/item/clothing/under/color/random
	shoes = /obj/item/clothing/shoes/black
