
# LL(1)

# E -> E' T
# E' -> T' (
# T -> + E'
# T -> e
# T' -> id

def producciones(lista, terminales):
	for x in range(len(lista)):
	produccion=lista[x]
	primero=produccion[1]
	if primero in terminales:
		uno=primero
	else:
		for y in range(len(lista)):
			p=lista[x]
			if p[0]==primero:
				producciones()
	if primero=='e':
		siguiente(produccion[0])


lista=[['E', "E'", 'T'], ["E'", "T'", '('], ['T', '+', "E'"], ['T', 'e'], ["T'", "id"]]
terminales=['(', '+', "id"]

producciones(lista, terminales)




	