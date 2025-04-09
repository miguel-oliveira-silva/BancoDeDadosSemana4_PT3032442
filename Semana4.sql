-- Questão 1. Gere uma lista de todos os instrutores, mostrando sua ID, nome e número de seções que eles ministraram. 
-- Não se esqueça de mostrar o número de seções como 0 para os instrutores que não ministraram qualquer seção. 
-- Sua consulta deverá utilizar outer join e não deverá utilizar subconsultas escalares.
SELECT INSTRUCTOR.ID, instructor.name, count(teaches.sec_id) AS num_sections from instructor left join
teaches on instructor.id = teaches.id group BY INSTRUCTOR.ID, instructor.name; 

--Questão 2. Escreva a mesma consulta do item anterior, mas usando uma subconsulta escalar, sem outer join.
SELECT instructor.ID, instructor.name, (select count(teaches.sec_id) FROM teaches WHERE teaches.ID = instructor.ID) AS num_sections
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
    	 
