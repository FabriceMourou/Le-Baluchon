![Imgur](https://i.imgur.com/8qawORu.png)

# Le Baluchon


Le Baluchon est une application de **trois** vues : 

- Pour naviguer, on utilise une barre d'onglet ("tab bar"), chaque onglet correspondant à une des trois vues.

- Lors des appels au réseau dans l'application, si une erreur a lieu, un message d'erreur apparaît sous forme de pop up en utilisant la classe UIAlertController.

## Currency
### Taux de change

Insérer un montant en euro(€) et voir le résultat en dollar($) et inversement.

Pour obtenir le taux de change, j’utilise l'API **fixer.io** , actualisé à chaque requête.


![Imgur](https://i.imgur.com/3uWSmVR.png)



## Weather
### Informations Météo

Dans les vues météo, nous avons deux écrans :
- Le premier est destiné à entrer le nom de la ville de son choix, ou de la ville de New York
- Le second est le résultat de ce choix avec de nombreuses informations météorologiques.

Pour chaque ville, j’affiche les conditions en temps réel en utilisant l'API OpenWeathermap.

![Imgur](https://i.imgur.com/52SfBUx.png)
