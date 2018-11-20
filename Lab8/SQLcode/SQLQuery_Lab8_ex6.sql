CREATE TABLE graph (
		Id_nr int PRIMARY KEY,
		dependent_nr int
		);

INSERT INTO graph VALUES
(5,0), (4,2), (3,2), (1,0), (2,1);

select * from graph

;WITH graph_cte AS (
		SELECT Id_nr , dependent_nr from graph
		where Id_nr = 3 and dependent_nr = 2
		
		UNION ALL
		
		SELECT graph.Id_nr, graph.dependent_nr from graph
		INNER JOIN graph_cte
		ON graph.ID_nr = graph_cte.dependent_nr
		
		
	
		
)
SELECT * from graph_cte

insert into graph values (0, null)