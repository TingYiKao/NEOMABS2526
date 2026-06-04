--0. Create a new database--
CREATE TABLE Exercise0 (
    ExerciseID INT NOT NULL UNIQUE,
    ExerciseName TEXT CHECK(length(ExerciseName) <= 25),
    PRIMARY KEY(ExerciseID)
);

--2. Insert a new table called Exercise, including two columns, ExerciseID and ExerciseName.--
CREATE TABLE Exercise (
    ExerciseID INT NOT NULL UNIQUE,
    ExerciseName TEXT CHECK(length(ExerciseName) <= 25),
    PRIMARY KEY(ExerciseID)
);

--3. Delete table Exercise0.--
DROP TABLE Exercise0;

--4. Insert a new table called Question, including three columns, QuestionID, ExerciseID, and QuestionText.--
CREATE TABLE Question (
    QuestionID INT NOT NULL UNIQUE,
    ExerciseID,
    QuestionText TEXT CHECK(length(ExerciseName) <= 125),
    PRIMARY KEY(QuestionID),
    FOREIGN KEY(ExerciseID) REFERENCES Exercise(ExerciseID));
    
--5. Insert a table called Answer, including 6 columns, QuestionID, Answer1, Answer2, Answer3, Answer4, and Points. 
--Answer is a weak entity and depends on Question. 
--Answer1, Answer2, Answer3, Answer4 are text, cannot be longer than 75 characters, 
--Answer1 and Answer2 cannot be NULL, Points is integer and cannot be NULL.
CREATE TABLE Answer (
    QuestionID INT NOT NULL,
    Answer1 TEXT  NOT NULL CHECK(length(Answer1) <= 75),
    Answer2 TEXT NOT NULL CHECK(length(Answer2) <= 75),
    Answer3 TEXT CHECK(length(Answer3) <= 75),
    Answer4 TEXT CHECK(length(Answer4) <= 75),
    Points INT NOT NULL,
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID));
    
--6. Insert at least three rows in each table
--0. Create a new database--
CREATE TABLE Exercise0 (
    ExerciseID INT NOT NULL UNIQUE,
    ExerciseName TEXT CHECK(length(ExerciseName) <= 25),
    PRIMARY KEY(ExerciseID)
);

--2. Insert a new table called Exercise, including two columns, ExerciseID and ExerciseName.--
CREATE TABLE Exercise (
    ExerciseID INT NOT NULL UNIQUE,
    ExerciseName TEXT CHECK(length(ExerciseName) <= 25),
    PRIMARY KEY(ExerciseID)
);

--3. Delete table Exercise0.--
DROP TABLE Exercise0;

--4. Insert a new table called Question, including three columns, QuestionID, ExerciseID, and QuestionText.--
CREATE TABLE Question (
    QuestionID INT NOT NULL UNIQUE,
    ExerciseID,
    QuestionText TEXT CHECK(length(ExerciseName) <= 125),
    PRIMARY KEY(QuestionID),
    FOREIGN KEY(ExerciseID) REFERENCES Exercise(ExerciseID));
    
--5. Insert a table called Answer, including 6 columns, QuestionID, Answer1, Answer2, Answer3, Answer4, and Points. 
--Answer is a weak entity and depends on Question. 
--Answer1, Answer2, Answer3, Answer4 are text, cannot be longer than 75 characters, 
--Answer1 and Answer2 cannot be NULL, Points is integer and cannot be NULL.
CREATE TABLE Answer (
    QuestionID INT NOT NULL,
    Answer1 TEXT  NOT NULL CHECK(length(Answer1) <= 75),
    Answer2 TEXT NOT NULL CHECK(length(Answer2) <= 75),
    Answer3 TEXT CHECK(length(Answer3) <= 75),
    Answer4 TEXT CHECK(length(Answer4) <= 75),
    Points INT NOT NULL,
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID));
    
--6. Insert at least three rows in each table
--0. Create a new database--
CREATE TABLE Exercise0 (
    ExerciseID INT NOT NULL UNIQUE,
    ExerciseName TEXT CHECK(length(ExerciseName) <= 25),
    PRIMARY KEY(ExerciseID)
);

--2. Insert a new table called Exercise, including two columns, ExerciseID and ExerciseName.--
CREATE TABLE Exercise (
    ExerciseID INT NOT NULL UNIQUE,
    ExerciseName TEXT CHECK(length(ExerciseName) <= 25),
    PRIMARY KEY(ExerciseID)
);

--3. Delete table Exercise0.--
DROP TABLE Exercise0;

--4. Insert a new table called Question, including three columns, QuestionID, ExerciseID, and QuestionText.--
CREATE TABLE Question (
    QuestionID INT NOT NULL UNIQUE,
    ExerciseID INT,
    QuestionText TEXT CHECK(length(ExerciseName) <= 125),
    PRIMARY KEY(QuestionID),
    FOREIGN KEY(ExerciseID) REFERENCES Exercise(ExerciseID));
    
--5. Insert a table called Answer, including 6 columns, QuestionID, Answer1, Answer2, Answer3, Answer4, and Points. 
--Answer is a weak entity and depends on Question. 
--Answer1, Answer2, Answer3, Answer4 are text, cannot be longer than 75 characters, 
--Answer1 and Answer2 cannot be NULL, Points is integer and cannot be NULL.
CREATE TABLE Answer (
    QuestionID INT NOT NULL,
    Answer1 TEXT  NOT NULL CHECK(length(Answer1) <= 75),
    Answer2 TEXT NOT NULL CHECK(length(Answer2) <= 75),
    Answer3 TEXT CHECK(length(Answer3) <= 75),
    Answer4 TEXT CHECK(length(Answer4) <= 75),
    Points INT NOT NULL,
    PRIMARY KEY(QuesitonID),
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID));
    
--6. Insert at least three rows in each table
INSERT INTO Exercise (ExerciseID, ExerciseName) VALUES
(1, 'Cardio Basics'),
(2, 'Strength Training'),
(3, 'Flexibility Workout');

UPDATE Exercise
SET ExerciseName = 'WenTing Xu'
WHERE ExerciseID = 1;

UPDATE Exercise
SET ExerciseName = 'Chen He'
WHERE ExerciseID = 2;

UPDATE Exercise
SET ExerciseName = 'TingYi KAO'
WHERE ExerciseID = 3;


INSERT INTO Question (QuestionID, ExerciseID, QuestionText) VALUES
(101, 1, 'What is the recommended duration for a basic cardio session?'),
(102, 2, 'Which muscle group is primarily targeted in squats?'),
(103, 3, 'What is the benefit of daily stretching exercises?');

INSERT INTO Answer (QuestionID, Answer1, Answer2, Answer3, Answer4, Points) VALUES
(101, '30 minutes', '45 minutes', '20 minutes', '60 minutes', 1),
(102, 'Leg muscles', 'Quadriceps', 'Glutes', 'Hamstrings', 2),
(103, 'Improves flexibility', 'Reduces muscle tension', 'Enhances posture', 'Boosts mobility', 3);







