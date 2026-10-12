/*
#DescStart#
#$Revision: 7138 $, $LastChangedBy: umeister $
#SubjectAreas#: Access Layer
#DescEnd#
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_org_store_busyear (busyear, client_id, store_id, lead_open_store_fg) AS
SELECT busyear,
 client_id,
 store_id,
 lead_open_store_fg
FROM ldl_p_lew_mart_msi.v_org_store_busyear;