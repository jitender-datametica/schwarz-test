-- 15.11.2021, srom0404, INC3846494, Attribut Lagernummer ist ohne wup_id und damit nicht eindeutig. Daher hier Eindeutigkeit über lagernummer_id herstellen

-- 20230717 staeblern Umstellung auf Session Variable

-- AP0016637, srom0404, es gibt Lagerorte, z. B. R009 in Möckmühl_1 (6906), die keiner Lagernummer zugeordnet sind

-- 20.12.2021, dknop, INC4021370, removing wup_id (9825, 9205)
 -- Erweiterung auf '-99'

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_lagernummer_spr_zu_1(USERID STRING) AS SELECT DISTINCT V01.lagernummer_bez,
 V01.lagernummer_id,
 V01.mandant_id,
 V01.nb_id,
 V01.spr_id,
 V01.wup_id
FROM kfl_production_dbp_msi_view3.tbl_mv_lagernummer_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_msi_view3.mv_user_spr_zu_1(USERID) AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.wup_id NOT IN (9825, 9205);