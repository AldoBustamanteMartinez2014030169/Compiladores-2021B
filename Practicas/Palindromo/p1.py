
# A->aBa
# B->bAb
# B->c

# c, aca, bacab, abacaba, babacabab || (a), (b), (ab), (aa), (bb), (bcb), (babcbab), (abcba), (ababcbaba)

def A(cadena, index, a, b, c):
	if cadena[index]=='a':
		if c==0:
			a=a+1
		else:
			a=a-1
		B(cadena, index+1, a, b, c)
	elif cadena[index]=='b':
		# no pertenece
	elif cadena[index]=='c':
		# no pertenece

def B(cadena, index, a, b, c):
	if cadena[index]=='b':
		if c==0:
			b=b+1
		else:
			b=b-1
		A(cadena, index+1, a, b, c)
	elif cadena[index]=='a':
		# no pertenece
	elif cadena[index]=='c' and c==0:
		c=1
		A(cadena, index+1, a, b, c)
	elif cadena[index]=='c' and c>0:
		# no pertenece
	

cadena="abacaba"

if cadena[0]=='a':
	A(cadena, 0, 0, 0, 0)
elif cadena[0]=='b':
	B(cadena, 0, 0, 0, 0)
elif cadena[0]=='c':
	# termina
else:
	# no pertenece