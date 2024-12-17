# Azure terraform scrip for ST Arbeidskrav 2 for å sette opp nettside med loadblanasert databaser

## Forutsetninger

1. Du har powershell 7
2. du har instalert terraform
3. du har instalert azure-cli

## Hvordan kjøre

1. Last ned filen som en zip og unzip den, dermed plaser mappen der du trenger den
2. Åpne powershell 7
3. Naviger til mappen
4. Bruk komandoen "terraform init"
5. Bruk komandoen "terraform plan"
6. du kommer til å få en feilmelding som ber deg om å logge inn med en az login -scope "lenken"
7. kopier den og kjør kommandoen, dermed logg inn
8. repiter fra steg 5 til du ikke får feilmelding
9. Bruk komandoen "terraform apply" dermed skriver du yes når den spør deg om det
10. la scriptet kjøre til du får suksess og kopier ipen du får på "web_vm_public_ip = "public ipen""
11. putt ipen inn i nettlesren og refresh til du får opp dataen, detta kan ta litt tid siden yaml scriptet kjører i bakgrunden,
du kommer nokk til å få opp en apache2 default nettside først, dette går bra, bare vent litt til.
