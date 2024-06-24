use school;

CREATE TABLE Students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    gender VARCHAR(10)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    enrollment_count INT DEFAULT 0
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES Students(id),
    CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);


BEGIN;


INSERT INTO Students (id, name, age, gender) VALUES
(1, 'Arpita', 18, 'Female'),
(2, 'Sunita', 19, 'Female'),
(3, 'Shivam', 20, 'Male');


INSERT INTO Courses (course_id, course_name) VALUES
(101, 'Mathematics'),
(102, 'Science');


COMMIT;

DELIMITER //
CREATE TRIGGER UpdateEnrollmentCount
AFTER INSERT ON Enrollments
FOR EACH ROW
BEGIN
    DECLARE course_enrollment_count INT;
    SELECT COUNT(*) INTO course_enrollment_count FROM Enrollments WHERE course_id = NEW.course_id;
    UPDATE Courses SET enrollment_count = course_enrollment_count WHERE course_id = NEW.course_id;
END //
DELIMITER ;


INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date) VALUES
(1, 1, 101, '2024-01-15');


SELECT * FROM Courses;

CREATE VIEW StudentCourseView AS
SELECT S.name AS student_name, S.age, S.gender, C.course_name
FROM Students S
JOIN Enrollments E ON S.id = E.student_id
JOIN Courses C ON E.course_id = C.course_id;


SELECT * FROM StudentCourseView;