extends Counter

func do_task():
	for order in OrderManager.orders:
		print(order)
		print(InventoryManager.inventory_names)
		if InventoryManager.inventory_names == order:
			print("WHOPE")
