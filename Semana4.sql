-- Questão 1. Gere uma lista de todos os instrutores, mostrando sua ID, nome e número de seções que eles ministraram. 
-- Não se esqueça de mostrar o número de seções como 0 para os instrutores que não ministraram qualquer seção. 
-- Sua consulta deverá utilizar outer join e não deverá utilizar subconsultas escalares.
SELECT INSTRUCTOR.ID, instructor.name, count(teaches.sec_id) AS num_sections from instructor left outer join
teaches on instructor.id = teaches.id group BY INSTRUCTOR.ID, instructor.name; 

--Questão 2. Escreva a mesma consulta do item anterior, mas usando uma subconsulta escalar, sem outer join.
SELECT instructor.ID, instructor.name, (select count(teaches.sec_id) 
FROM teaches WHERE teaches.ID = instructor.ID) AS num_sections
FROM instructor;

-- Questão 3. Gere a lista de todas as seções de curso oferecidas na primavera de 2010, junto com o nome dos instrutores ministrando a seção. 
--Se uma seção tiver mais de 1 instrutor, ela deverá aparecer uma vez no resultado para cada instrutor. Se não tiver instrutor algum,
-- ela ainda deverá aparecer no resultado, com o nome do instrutor definido como “-”.
	SELECT 
	    teaches.course_id, teaches.sec_id, instructor.id as ID, teaches.semester, teaches.year,
	    Case WHEN instructor.name IS NULL 
	    THEN '-' 
	    else instructor.name END AS instrutor
		from
			instructor
			right join 
	   	 	teaches
	    	on instructor.ID = teaches.ID 
		where 
	   		 teaches.semester = 'Spring' 
	   		 AND teaches.year = 2010
	   	 ORDER BY 
   		 teaches.course_id Asc;
--Questão 4. Suponha que você tenha recebido uma relação grade_points (grade, points), que oferece uma conversão de conceitos (letras)
--na relação takes para notas numéricas; por exemplo, uma nota “A+” poderia ser especificada para corresponder a 4 pontos, 
--um “A” para 3,7 pontos, e “A-” para 3,4, e “B+” para 3,1 pontos, e assim por diante. 
--Os Pontos totais obtidos por um aluno para uma oferta de curso (section) são definidos como o número de créditos para o
--curso multiplicado pelos pontos numéricos para a nota que o aluno recebeu.
--Dada essa relação e o nosso esquema university, escreva: 
--Ache os pontos totais recebidos por aluno, para todos os cursos realizados por ele.
    select student.id, student.name, course.title, department.dept_name, course.credits, grade_points.grade, grade_points.points, grade_points.points *  course.credits as Pontos_totais
FROM student
inner JOIN 
    takes ON student.id = takes.id
inner JOIN 
    course ON takes.course_id = course.course_id
inner JOIN 
    department ON course.dept_name = department.dept_name
inner JOIN 
    grade_points ON takes.grade = grade_points.grade;
--Questão 5. Crie uma view a partir do resultado da Questão 4 com o nome “coeficiente_rendimento”.

CREATE VIEW coeficiente_rendimento AS
 select student.id, student.name, course.title, department.dept_name, course.credits, grade_points.grade, grade_points.points, grade_points.points *  course.credits as Pontos_totais
FROM student
inner JOIN 
    takes ON student.id = takes.id
inner JOIN 
    course ON takes.course_id = course.course_id
inner JOIN 
    department ON course.dept_name = department.dept_name
inner JOIN 
    grade_points ON takes.grade = grade_points.grade;


