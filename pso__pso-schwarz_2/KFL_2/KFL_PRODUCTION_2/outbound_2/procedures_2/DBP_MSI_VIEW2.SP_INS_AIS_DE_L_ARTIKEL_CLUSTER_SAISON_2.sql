CREATE OR REPLACE PROCEDURE dbp_msi_view2.sp_ins_ais_de_l_artikel_cluster_saison(IN P_CLUSTER_DESC STRING, OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;
INSERT INTO dbp_msi_view2.ts_ais_de_l_ek_saison_2 (ek_saison_id, ek_saison_bez)
(SELECT COALESCE(MAX(ek_saison_id), 0) + 1, P_CLUSTER_DESC
    FROM dbp_msi_view2.ts_ais_de_l_ek_saison_2);
COMMIT TRANSACTION;
SET out_param  =  'Neues Cluster angelegt';
SELECT out_param;
RETURN;
END;