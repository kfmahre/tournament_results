-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.
DROP DATABASE if exists tournament;

CREATE DATABASE tournament;

\c tournament;

CREATE TABLE Players (
  name text,
  id serial PRIMARY KEY
  );

CREATE TABLE Match (
  win integer REFERENCES Players,
  loss integer REFERENCES Players,
  match_id serial PRIMARY KEY
  );

-- Inserts I made to originally play with the database
INSERT INTO Players (name) VALUES ('Brian');
INSERT INTO Players (name) VALUES ('Mark');
INSERT INTO Players (name) VALUES ('Timmy');
INSERT INTO Players (name) VALUES ('Tanner');
insert into match (win,loss) values (1,2);
insert into match (win,loss) values (3,4);
insert into match (win,loss) values (3,2);
insert into match (win,loss) values (4,1);

-- A VIEW to show how many wins each player has
CREATE VIEW v_wins AS
    SELECT Players.id, count(Match.win)
    AS v_wins
    FROM Players
    LEFT JOIN Match
    ON Players.id=Match.win
    GROUP BY Players.id
    ORDER BY Players.id;

-- A view to show how many matches each player played
CREATE VIEW v_matches AS
    SELECT Players.id, count(Match.*)
    AS v_matches
    FROM Players
    LEFT JOIN Match
    ON Players.id=Match.win
    OR Players.id=Match.loss
    GROUP BY Players.id
    ORDER BY Players.id;

CREATE VIEW v_standings AS
    SELECT Players.id, Players.name,
    v_wins.v_wins, v_matches.v_matches
    FROM Players
    JOIN v_wins
    ON Players.id=v_wins.id
    JOIN v_matches
    ON v_wins.id=v_matches.id
    ORDER BY v_wins.v_wins
    DESC, Players.id
    ASC;

