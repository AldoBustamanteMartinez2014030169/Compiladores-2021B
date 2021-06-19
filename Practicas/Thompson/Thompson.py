
# Thompson

# a, b, |, *
# a, a*, ab, abab

lista=[]
inicial=1
final=1

cadena="ab"

for x in range(len(cadena)):

	if cadena[x]=='a':
		if x==0:
			lista.append([1, 2, 'a'])
			final=2
		else:
			anterior=lista[-1]
			lista.append([anterior[1], anterior[1]+1, 'a'])
			final=anterior[1]+1

	if cadena[x]=='b':
		if x==0:
			lista.append([1, 2, 'b'])
			final=2
		else:
			anterior=lista[-1]
			lista.append([anterior[1], anterior[1]+1, 'b'])
			final=anterior[1]+1

for estados in lista:
	print(estados)

print("Estado inicial: ", inicial)
print("Estado final: ", final)
	# if cadena[x]=='|'

