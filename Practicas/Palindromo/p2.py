
def A(cadena, cont, tam):
	if(cadena[tam-1]=='a'):
		return 1
	else:
		return 0

def B(cadena, cont, tam):
	if(cadena[tam-1]=='b'):
		return 1
	else:
		return 0

cadena="aabcbaa"
tam=len(cadena)
tamaux=len(cadena)
cont = 0

for x in cadena:
	if cont<(tamaux/2):
		if x=='a':
			if A(cadena, cont, tam)==1:
				cont=cont+1
				tam=tam-1
			else:
				print("no pertenece A")
		
		elif x=='b':
			if B(cadena, cont, tam)==1:
				cont=cont+1
				tam=tam-1
			else:
				print("no pertenece B")

		elif x=='c':
			if cont!=tam/2:
				print("no pertenece")
		
print(cadena)