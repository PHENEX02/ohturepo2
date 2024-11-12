# src/player_reader.py

"""
This module provides classes for player data handling.
"""

class Player:
    """Represents a player with a name, team, and points."""

    def __init__(self, name, team, points):
        self.name = name
        self.team = team
        self.points = points

    def __repr__(self):
        """Returns a string representation of the player."""
        return f"{self.name} ({self.team}) - {self.points} points"


class PlayerReader:
    """
    Provides a method to retrieve player data.
    This version uses a hardcoded list for demonstration.
    """

    def __init__(self):
        self._players_data = [
            "John Doe,TeamA,45",
            "Jane Smith,TeamB,52",
            "Mike Johnson,TeamA,37",
            "Emily Davis,TeamC,60"
        ]

    def get_players(self):
        """Parses and returns a list of Player objects from the hardcoded data."""
        players = []
        for line in self._players_data:
            name, team, points = line.split(',')
            players.append(Player(name.strip(), team.strip(), int(points.strip())))
        return players


# src/statistics_service.py

"""
This module provides a statistics service for player data analysis.
"""

class StatisticsService:
    """
    Provides various methods to query and analyze player data.
    """

    def __init__(self, player_reader):
        """
        Initializes the service with a player reader, which provides player data.

        Args:
            player_reader (PlayerReader): An instance of PlayerReader containing player data.
        """
        self._players = player_reader.get_players()

    def search(self, name):
        """
        Searches for a player by name.

        Args:
            name (str): The name or partial name of the player to search.

        Returns:
            Player or None: The first matching Player object, or None if no match is found.
        """
        for player in self._players:
            if name in player.name:
                return player
        return None

    def team(self, team_name):
        """
        Retrieves all players in the specified team.

        Args:
            team_name (str): The team name to filter by.

        Returns:
            list of Player: A list of players who are in the specified team.
        """
        players_of_team = filter(
            lambda player: player.team == team_name,
            self._players
        )
        return list(players_of_team)

    def top(self, how_many):
        """
        Retrieves the top scoring players.

        Args:
            how_many (int): The number of top players to retrieve.

        Returns:
            list of Player: A list of the top scoring players.
        """
        def sort_by_points(player):
            return player.points

        sorted_players = sorted(
            self._players,
            reverse=True,
            key=sort_by_points
        )
        return sorted_players[:how_many]


# src/main.py

"""
Main program to test the functionality of PlayerReader and StatisticsService.
"""

from player_reader import PlayerReader
from statistics_service import StatisticsService

# Initialize PlayerReader and StatisticsService
player_reader = PlayerReader()
stats = StatisticsService(player_reader)

# Example calls
print(stats.search("Jane Smith"))    # Searches for player by name
print(stats.team("TeamA"))           # Lists players in a specific team
print(stats.top(2))                  # Lists top 2 players by points
