# Guida per principianti all'utilizzo di questo modello.

Questa guida ti guiderà attraverso i passaggi per utilizzare questo modello. Anche se questa guida è rivolta ai principianti nell'uso di GitHub e nella configurazione di app avanzate per Swift Playground, includeremo comunque collegamenti e riferimenti per studiare ulteriori tecniche avanzate.

## Prerequisiti

- Un account GitHub creato su [GitHub.com](https://github.com/join).
- Comprensione di base dei file json.

## Iniziare

1. Accedi al tuo account GitHub e vai alla [pagina principale del modello](https://github.com/Fra146/swift-subscription).
2. Fai clic sul pulsante verde "Usa questo modello" e scegli "Crea un nuovo repository" dal menu a discesa.

## Configurazione del repository

1. Dai un nome al tuo nuovo repository (e opzionalmente, una descrizione).
> Se sei un utente GitHub gratuito, dovrai utilizzare `NOME_DEL_TUO_ACCOUNT.github.io` come nome del tuo repository e impostare il tuo repository come pubblico per utilizzare GitHub Pages.
> Se sei uno studente, potresti essere idoneo a una sottoscrizione gratuita di GitHub Pro iscrivendoti al [GitHub Campus Program](https://education.github.com/).
2. Accedi al tuo nuovo repository e fai clic su "Impostazioni". Scegli "Pages" dal menu sul lato sinistro. Scegli "master" come branch di origine e premi "Salva".
3. Il tuo sito web di GitHub Pages sarà ora disponibile su `https://NOME_DEL_TUO_ACCOUNT.github.io`. Se non è disponibile, attendi circa 10 minuti e prova ad accedere nuovamente al sito web. Se incontri ulteriori problemi, consulta la [Documentazione di GitHub Pages](https://docs.github.com/en/pages).
> Puoi eliminare in sicurezza la cartella vuota fornita.

![image](https://github.com/Fra146/swift-subscription/assets/61921751/7ca60d9c-1b2b-4590-9824-eec9e1ca2b85)

## Carica un progetto di Swift Playground

1. Prepara la versione esportata del progetto di Swift Playground aprendo il progetto su Swift Playground, quindi scegliendo "Tre punti in alto -> Avanzate -> Esporta". Nei campi, scrivi un titolo personalizzato per il tuo progetto e come ID dei contenuti scrivi il DNS inverso della tua distribuzione GitHub Pages e un nome comune per il progetto. Nel mio caso, sarà `io.github.fra146.void` poiché il nome comune del mio progetto è "void" e il sito web si trova su `fra146.github.io`.
2. Crea una nuova cartella per il tuo progetto premendo "Aggiungi file" dalla pagina principale del tuo repository, quindi "Crea nuovo file". Inserisci come nome del file `NOME_PROGETTO_COMUNE/.` (sostituisci NOME_PROGETTO_COMUNE con il nome comune del progetto che utilizzerai durante la distribuzione. Seguendo il mio esempio al passo uno, userò "void") e, nel nuovo campo che appare, `placeholder.txt`. Scorri verso il basso e premi "Commit new file".
> Per un utilizzo avanzato di Git, consulta la [documentazione](https://git-scm.com/doc).
3. Nella tua nuova cartella, premi "Aggiungi file", quindi "Carica file". Ora **carica una versione compressa (.zip) del playground esportato**, chiamata `NOME_PROGETTO_COMUNE.playgroundbook.zip`. Nel mio caso, userò `void.playgroundbook.zip`.
![image](https://github.com/Fra146/swift-subscription/assets/61921751/81d0978e-f7bf-4ec1-8df0-90021cd4d2a7)

## Personalizza la tua pagina

Per ogni progetto, nella sua cartella dedicata, puoi aggiungere alcune immagini per arricchire la pagina di download.
- La miniatura deve essere di esattamente 902x678 pixel (esempio di nome file, thumb.png).
- Il banner deve essere di esattamente 1080x400 pixel (esempio di nome file, banner.png).
- Le immagini di anteprima devono essere di esattamente (esempio di nome file, prev1.png, prev2.png, prev3.png, ...).

## Modifica il feed.json radice

Il file feed.json conterrà informazioni su ciascun playground fornito con il rilascio.
Verifica il feed.json fornito per capire cosa inserire nei campi.
> Nel campo feedIdentifier, inserisci il DNS inverso della radice delle pagine GitHub. Nel mio esempio userò `io.github.fra146`.
> In ogni campo contentIdentifier, inserisci il DNS inverso della posizione del playground. Questo deve iniziare con feedIdentifier. Nel mio esempio userò `io.github.fra146.void`.

## Verifica il sito web pubblicato

Controlla sul lato destro della radice del repository GitHub la sezione "Environments". Fai clic su "github-pages", quindi su "View deployment".

## Condivisione dell'iscrizione al playground

Per aggiungere l'iscrizione al playground alla tua app di Swift Playground, vai a Swift Playground, apri la schermata "Altro playground", scorri verso il basso e premi "Iscriviti tramite URL". Qui dovrai aggiungere la posizione precisa del feed.json. Nel mio caso, sarà `https://fra146.github.io/feed.json`.
![image](https://github.com/Fra146/swift-subscription/assets/61921751/c977325a-fa0d-474d-b2fe-4dcbfb7fa013)
