
# Thompson

# a, b, |, *
# a, a*, ab, abab

def grafo(cadena, lista, inicial, final):

	for x in range(len(cadena)):

		if cadena[x]!='|':
			if x==0:
				lista.append([1, 2, cadena[x]])
				final=2
			else:
				anterior=lista[-1]
				lista.append([anterior[1], anterior[1]+1, cadena[x]])
				final=anterior[1]+1
		else:
			anterior=lista[-1]
			lista.append([anterior[1]+1, inicial, 'E'])
			lista.append([anterior[1], anterior[1]+2, 'E'])
			inicial=anterior[1]+1
			final=anterior[1]+2
			# subcadena=cadena[x:-1]
			# grafo(subcadena, lista, inicial, final)


lista=[]
inicial=1
final=1

cadena="ab|ba"

grafo(cadena, lista, inicial, final)

for estados in lista:
	print(estados)

print("Estado inicial: ", inicial)
print("Estado final: ", final)

