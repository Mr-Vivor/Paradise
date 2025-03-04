/*///////////////Circuit Imprinter (By Darem)////////////////////////
	Used to print new circuit boards (for computers and similar systems) and AI modules. Each circuit board pattern are stored in
a /datum/desgin on the linked R&D console. You can then print them out in a fasion similar to a regular lathe. However, instead of
using metal and glass, it uses glass and reagents (usually sulfuric acis).

*/
/obj/machinery/r_n_d/circuit_imprinter
	name = "Circuit Imprinter"
	desc = "Manufactures circuit boards for the construction of machines."
	icon_state = "circuit_imprinter"
	base_icon_state = "circuit_imprinter"
	container_type = OPENCONTAINER

	categories = list(
								"AI Modules",
								"Computer Boards",
								"Engineering Machinery",
								"Exosuit Modules",
								"Hydroponics Machinery",
								"Medical Machinery",
								"Misc. Machinery",
								"Research Machinery",
								"Subspace Telecomms",
								"Teleportation Machinery"
								)

	reagents = new()

/obj/machinery/r_n_d/circuit_imprinter/New()
	..()
	component_parts = list()
	component_parts += new /obj/item/circuitboard/circuit_imprinter(null)
	component_parts += new /obj/item/stock_parts/matter_bin(null)
	component_parts += new /obj/item/stock_parts/manipulator(null)
	component_parts += new /obj/item/reagent_containers/glass/beaker(null)
	component_parts += new /obj/item/reagent_containers/glass/beaker(null)
	RefreshParts()
	if(is_taipan(z))
		icon_state = "syndie_circuit_imprinter"
		base_icon_state = "syndie_circuit_imprinter"
	reagents.my_atom = src

/obj/machinery/r_n_d/circuit_imprinter/upgraded/New()
	..()
	component_parts = list()
	component_parts += new /obj/item/circuitboard/circuit_imprinter(null)
	component_parts += new /obj/item/stock_parts/matter_bin/super(null)
	component_parts += new /obj/item/stock_parts/manipulator/pico(null)
	component_parts += new /obj/item/reagent_containers/glass/beaker/large(null)
	component_parts += new /obj/item/reagent_containers/glass/beaker/large(null)
	RefreshParts()
	if(is_taipan(z))
		icon_state = "syndie_circuit_imprinter"
		base_icon_state = "syndie_circuit_imprinter"
	reagents.my_atom = src

/obj/machinery/r_n_d/circuit_imprinter/RefreshParts()
	reagents.maximum_volume = 0
	for(var/obj/item/reagent_containers/glass/G in component_parts)
		reagents.maximum_volume += G.volume
		G.reagents.trans_to(src, G.reagents.total_volume)

	materials.max_amount = 0
	for(var/obj/item/stock_parts/matter_bin/M in component_parts)
		materials.max_amount += M.rating * 75000

	var/T = 0
	for(var/obj/item/stock_parts/manipulator/M in component_parts)
		T += M.rating
	T = clamp(T, 1, 4)
	efficiency_coeff = 1 / (2 ** (T - 1))

/obj/machinery/r_n_d/circuit_imprinter/check_mat(datum/design/being_built, M)
	var/list/all_materials = being_built.reagents_list + being_built.materials

	var/A = materials.amount(M)
	if(!A)
		A = reagents.get_reagent_amount(M)

	return round(A / max(1, (all_materials[M] * efficiency_coeff)))

/obj/machinery/r_n_d/circuit_imprinter/attackby(obj/item/O, mob/user, params)
	if(shocked)
		add_fingerprint(user)
		if(shock(user,50))
			return TRUE
	if(default_deconstruction_screwdriver(user, "[base_icon_state]_t", base_icon_state, O))
		add_fingerprint(user)
		if(linked_console)
			linked_console.linked_imprinter = null
			linked_console = null
		return

	if(exchange_parts(user, O))
		return

	if(panel_open)
		if(O.tool_behaviour == TOOL_CROWBAR)
			for(var/obj/I in component_parts)
				if(istype(I, /obj/item/reagent_containers/glass/beaker))
					reagents.trans_to(I, reagents.total_volume)
				I.loc = src.loc
			materials.retrieve_all()
			default_deconstruction_crowbar(user, O)
			return
		else
			to_chat(user, "<span class='warning'>You can't load the [src.name] while it's opened.</span>")
			return
	if(O.is_open_container())
		return FALSE
	else
		return ..()
