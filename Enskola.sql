---Jag valde skolan eftersom jag tänkte jag kan skapa 4 tabeller med skolinfo, skolavdelningar, studenter, och skolpersonal. Läst dock att man inte får använda studenter pga man har använt det i lektionen (jag har säkert missat den delen i lektionen) så jag har nu 3 tabeller och hoppas att inte få IG eftersom jag har faktiskt inte kopierat dessa---
--- Skapade första tabellen innan data inmatning. Varchar till location och head name då jag tänkte att kanske ha ett långt namn men hadé inte gjort det så det kunde vara max 50 characters istället.
--- FacultyID för varje skolavdelning så det blev primary key här, hade tänkt blanda bokstäver och siffror men gick inte med autoincrement---

CREATE TABLE SchoolInformation(
    FacultyID                INTEGER PRIMARY KEY AUTOINCREMENT ,
    FacultyName              TEXT NOT NULL,
    FacultyLocation          VARCHAR(100),
    FacultyHeadName          VARCHAR(100),
    FacultyNumberOfStudent   INTEGER,
    FacultyNumberOfEmployees INTEGER
);

--- Eftersom FacultyID är primary key med autoincrement så blev det not null för att programmet ska generera ID integer istället. ---

INSERT INTO SchoolInformation (FacultyID, FacultyName, FacultyLocation, FacultyHeadName, FacultyNumberOfStudent, FacultyNumberOfEmployees)
VALUES (NOT NULL, 'Arts', 'A1', 'Art Konst', '60', '20'),
( NOT NULL, 'Business Administration', 'B1', 'Marky Market', '30', '15'),
(NOT NULL, 'Computer Science', 'C1','Dotty Comp', '80','35'),
(NOT NULL, 'Education', 'E1', 'Edu Teach', '20', '10'),
(NOT NULL, 'Engineering','E2', 'Mech A. Bellum', '30', '15'),
(NOT NULL, 'Science', 'S1','Graham Bell', '60', '25'),
(NOT NULL, 'Social Studies', 'S2', 'Soc Demos','20', '5');


---Skapade sedan SchoolFaculty---
---Foreign key lagt till här---
CREATE TABLE SchoolFaculty (
    ProgramID INTEGER PRIMARY KEY AUTOINCREMENT,
    ProgramName VARCHAR (100),
    ClassID VARCHAR (100),
    ClassName VARCHAR (100),
    FacultyID INTEGER,
        FOREIGN KEY (FacultyID) REFERENCES SchoolInformation (FacultyID)
);


---Här valde jag att ge en start integer 10011, sen får programmet generera resterande integer---
---Jag vet inte om det finns ett finare, bättre, och enklare sätt att få genererat FacultyID på foreign key DepartmentID rader så jag använde select funktion istället---

INSERT INTO SchoolFaculty (ProgramID, ProgramName, ClassID, ClassName, FacultyID)
VALUES ('10011', 'Advertising', 'AdHT25', 'Advertising Hösttermin 2025', (SELECT FacultyID FROM SchoolInformation WHERE FacultyName = 'Arts')),
       ( NOT NULL,'Business Administration', 'BaHT25', 'Business Administration Hösttermin 2025', (SELECT FacultyID FROM SchoolInformation WHERE FacultyName = 'Business Administration')),
    ( NOT NULL, 'Datavetenskap', 'DataVT25', 'Datavetenskap Vårtermin 2025', (SELECT FacultyID FROM SchoolInformation WHERE FacultyName = 'Computer Science')),
    (NOT NULL, 'Mechanical Engineering', 'MechHT25', 'Mechanical Engineering Hösttermin 2025', (SELECT FacultyID FROM SchoolInformation WHERE FacultyLocation = 'E2')),
    ( NOT NULL, 'Natural Sciences', 'NatVT26', 'Natural Sciences Vårtermin 2026', (SELECT FacultyID FROM SchoolInformation WHERE FacultyHeadName= 'Graham Bell'))
   ;

---Skapade sedan en tabell för board of members---

CREATE TABLE SchoolBoardMember (
    BoardMemberID INTEGER Primary Key AUTOINCREMENT ,
    BoardMemberFörnamn VARCHAR(100),
    BoardMemberEfternamn VARCHAR(100),
    FacultyName VARCHAR (100) UNIQUE
);


---Här ville jag också starta med något som blev 111 ---


INSERT INTO SchoolBoardMember (BoardMemberID, BoardMemberFörnamn, BoardMemberEfternamn, FacultyName)
VALUES ('111', 'Hercule', 'Poirot', 'Fine Arts'),
       (NOT NULL, 'Mickey', 'Mouse', 'Business Administration'),
       (NOT NULL, 'Hermione', 'Granger','Advertising'),
       (NOT NULL, 'Bilbo', 'Baggins', 'Economics'),
       (NOT NULL,  'Felonious', 'Gru', 'Social Studies');

DROP TABLE SchoolBoardMember; -- ta bort hela tabellen


---Insert hade jag redan gjort med 3 inserter (1 insert flera rader per tabell)---
--- Mary Poppins fick inte Grus BoardMemberID 115 efter radering, hon fick istället 116 ---
INSERT INTO SchoolBoardMember (BoardMemberID, BoardMemberFörnamn, BoardMemberEfternamn, FacultyName)
VALUES (NOT NULL, 'Mary','Poppins', 'Civil Engineering');

---Det finns två avdelningar med 60 studenter enligt SchoolInformation tabell---
SELECT * FROM SchoolInformation WHERE FacultyNumberOfStudent = '60';

---finns bara en Hercule Poirot ---
SELECT BoardMemberFörnamn, BoardMemberEfternamn FROM SchoolBoardMember WHERE FacultyName = 'Fine Arts' ;

---Gemensam för båda tabellerna är endast business administration och social studies, detta pga fine arts, economics, civil engineering, och advertising finns inte motsvarande under department name i Schoolinformation ---
SELECT FacultyLocation FROM SchoolInformation INNER JOIN SchoolBoardMember SBM on SchoolInformation.FacultyName = SBM.FacultyName  ;


--- Mickey är nu Minnie ---
UPDATE SchoolBoardMember SET BoardMemberFörnamn = 'Minnie' WHERE BoardMemberEfternamn = 'Mouse';


---felonius gru finns inte med i tabellen nu --

DELETE FROM SchoolBoardMember WHERE BoardMemberEfternamn = 'Gru';
