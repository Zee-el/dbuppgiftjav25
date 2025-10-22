---Jag valde skolan eftersom jag tänkte jag kan skapa 4 tabeller med skolinfo, skolavdelningar, studenter, och skolpersonal. Läst dock att man inte får använda studenter pga man har använt det i lektionen (jag har säkert missat den delen i lektionen) så jag har nu 3 tabeller och hoppas att inte få IG eftersom jag har faktiskt inte kopierat dessa---
--- Skapade första tabellen innan data inmatning. Varchar till location och head name då jag tänkte att kanske ha ett långt namn men hadé inte gjort det så det kunde vara max 50 characters istället.
--- DepartmentID för varje skolavdelning så det blev primary key här, hade tänkt blanda bokstäver och siffror men gick inte med autoincrement---

CREATE TABLE SchoolInformation(
    DepartmentID                INTEGER PRIMARY KEY AUTOINCREMENT ,
    DepartmentName              TEXT NOT NULL,
    DepartmentLocation          VARCHAR(100),
    DepartmentHeadName          VARCHAR(100),
    DepartmentNumberOfStudent   INTEGER,
    DepartmentNumberOfEmployees INTEGER
);

--- Eftersom DepartmentID är primary key med autoincrement så blev det not null för att programmet ska generera ID integer istället. ---

INSERT INTO SchoolInformation (DepartmentID, DepartmentName, DepartmentLocation, DepartmentHeadName, DepartmentNumberOfStudent, DepartmentNumberOfEmployees)
VALUES (NOT NULL, 'Arts', 'A1', 'Art Konst', '60', '20'),
( NOT NULL, 'Business Administration', 'B1', 'Marky Market', '30', '15'),
(NOT NULL, 'Computer Science', 'C1','Dotty Comp', '80','35'),
(NOT NULL, 'Education', 'E1', 'Edu Teach', '20', '10'),
(NOT NULL, 'Engineering','E2', 'Mech A. Bellum', '30', '15'),
(NOT NULL, 'Science', 'S1','Graham Bell', '60', '25'),
(NOT NULL, 'Social Studies', 'S2', 'Soc Demos','20', '5');


---Skapade sedan SchoolDepartment---
---Foreign key lagt till här---
CREATE TABLE SchoolDepartment (
    ProgramID INTEGER PRIMARY KEY AUTOINCREMENT,
    ProgramName VARCHAR (100),
    ClassID VARCHAR (100),
    ClassName VARCHAR (100),
    DepartmentID INTEGER,
        FOREIGN KEY (DepartmentID) REFERENCES SchoolInformation (DepartmentID)
);


---Här valde jag att ge en start integer 10011, sen får programmet generera resterande integer---
---Jag vet inte om det finns ett finare, bättre, och enklare sätt att få genererat DepartmentID på foreign key DepartmentID rader så jag använde select funktion istället---

INSERT INTO SchoolDepartment (ProgramID, ProgramName, ClassID, ClassName, DepartmentID)
VALUES ('10011', 'Advertising', 'AdHT25', 'Advertising Hösttermin 2025', (SELECT DepartmentID FROM SchoolInformation WHERE DepartmentName = 'Arts')),
       ( NOT NULL,'Business Administration', 'BaHT25', 'Business Administration Hösttermin 2025', (SELECT DepartmentID FROM SchoolInformation WHERE DepartmentName = 'Business Administration')),
    ( NOT NULL, 'Datavetenskap', 'DataVT25', 'Datavetenskap Vårtermin 2025', (SELECT DepartmentID FROM SchoolInformation WHERE DepartmentName = 'Computer Science')),
    (NOT NULL, 'Mechanical Engineering', 'MechHT25', 'Mechanical Engineering Hösttermin 2025', (SELECT DepartmentID FROM SchoolInformation WHERE DepartmentLocation = 'E2')),
    ( NOT NULL, 'Natural Sciences', 'NatVT26', 'Natural Sciences Vårtermin 2026', (SELECT DepartmentID FROM SchoolInformation WHERE DepartmentHeadName= 'Graham Bell'))
   ;

---Skapade sedan en tabell för medarbetarna---

CREATE TABLE SchoolEmployees (
    EmployeeID INTEGER Primary Key AUTOINCREMENT ,
    EmployeeFörnamn VARCHAR(100),
    EmployeeEfternamn VARCHAR(100),
    DepartmentName VARCHAR (100) UNIQUE
);


---Här ville jag också starta med något som blev 111 ---


INSERT INTO SchoolEmployees (EmployeeID, EmployeeFörnamn, EmployeeEfternamn, DepartmentName)
VALUES ('111', 'Hercule', 'Poirot', 'Fine Arts'),
       (NOT NULL, 'Mickey', 'Mouse', 'Business Administration'),
       (NOT NULL, 'Hermione', 'Granger','Advertising'),
       (NOT NULL, 'Bilbo', 'Baggins', 'Economics'),
       (NOT NULL,  'Felonious', 'Gru', 'Social Studies');

DROP TABLE SchoolEmployees; -- ta bort hela tabellen


---Insert hade jag redan gjort med 3 inserter (1 insert flera rader per tabell)---
--- Mary Poppins fick inte Grus EmployeeID 115 efter radering, hon fick istället 116 ---
INSERT INTO SchoolEmployees (EmployeeID, EmployeeFörnamn, EmployeeEfternamn, DepartmentName)
VALUES (NOT NULL, 'Mary','Poppins', 'Civil Engineering');

---Det finns två avdelningar med 60 studenter enligt SchoolInformation tabell---
SELECT * FROM SchoolInformation WHERE DepartmentNumberOfStudent = '60';

---finns bara en Hercule Poirot ---
SELECT EmployeeFörnamn, EmployeeEfternamn FROM SchoolEmployees WHERE DepartmentName = 'Fine Arts' ;

---Gemensam för båda tabellerna är endast business administration och social studies, detta pga fine arts, economics, civil engineering, och advertising finns inte motsvarande under department name i Schoolinformation ---
SELECT DepartmentLocation FROM main.SchoolInformation INNER JOIN SchoolEmployees SE on SchoolInformation.DepartmentName = SE.DepartmentName  ;


--- Mickey är nu Minnie ---
UPDATE SchoolEmployees SET EmployeeFörnamn = 'Minnie' WHERE EmployeeEfternamn = 'Mouse';


---felonius gru finns inte med i tabellen nu --
DELETE FROM SchoolEmployees WHERE EmployeeEfternamn = 'Gru';