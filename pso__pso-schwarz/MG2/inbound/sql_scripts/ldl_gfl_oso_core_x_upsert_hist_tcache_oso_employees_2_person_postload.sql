delete from core_rel.t_person
 where dwh_node_cd = 'P_LEW_CORE'
   and first_name||family_name in ( select first_name||family_name from core_rel.t_person where dwh_node_cd = 'OSO');
