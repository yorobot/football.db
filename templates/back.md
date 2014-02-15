
<!-- back page stuff
  -->

Stats:

- {{ Team.where( club: false ).count }} National Teams
- {{ Team.where( club: true ).count}} Clubs
- {{ Game.count }} Games
- {{ League.count }} Leagues & Tournaments
- {{ Event.count }} Events
- {{ Ground.count  }} Stadiums

