#!/usr/bin/env -S python3
import random, string

# Definieer de tekengroepen
upper = string.ascii_uppercase
lower = string.ascii_lowercase
digits = string.digits
symbols = "_-@#%+="# Veilige symbolen

# Pak gegarandeerd van elke categorie minimaal 1 teken
u = random.choice(upper)
l = random.choice(lower)
d = random.choice(digits)
s = random.choice(symbols)

# Vul de overige 12 tekens willekeurig aan (totaal 16 tekens)
all_chars = upper + lower + digits + symbols
rest = [random.choice(all_chars) for _ in range(12)]

# Combineer alles en schud de volgorde door elkaar
pwd = list(u + l + d + s + "".join(rest))
random.shuffle(pwd)

# Print het uiteindelijke wachtwoord
print("".join(pwd))
