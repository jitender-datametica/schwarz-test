CREATE OR REPLACE PROCEDURE dbp_msi_view2.sp_ups_ais_de_artikel_cluster_saison_zu(IN P_CLUSTER_ID BIGNUMERIC, IN P_DAT_VON STRING, IN P_DAT_BIS STRING, IN P_KL_ARTIKELLISTE STRING, IN P_LOESCHEN BIGNUMERIC, OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;
DELETE FROM dbp_msi_view2.ts_ais_de_ek_saison_art_zu_2
WHERE ek_saison_id = P_CLUSTER_ID AND dat_gueltig_von = CAST(P_DAT_VON AS DATE) 
AND dat_gueltig_bis = CAST(P_DAT_BIS AS DATE);

IF P_LOESCHEN = 0 THEN
    INSERT INTO dbp_msi_view2.ts_ais_de_ek_saison_art_zu_2 (mandant_id, art_id, ek_saison_id, dat_gueltig_von, dat_gueltig_bis, kl_art_id_liste_txt)
(SELECT DISTINCT mandant_id, art_id, CAST(P_CLUSTER_ID AS INTEGER), CAST(P_DAT_VON AS DATE), CAST(P_DAT_BIS AS DATE), P_KL_ARTIKELLISTE
    FROM dbp_view.v_art_2
    WHERE kl_art_id IN (SELECT ROUND(CAST(VALUE AS BIGNUMERIC), 0) AS value
                FROM (SELECT 1 AS seq) AS t
                    INNER JOIN UNNEST(SPLIT(P_KL_ARTIKELLISTE, ';')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND mandant_id = 1);
END IF;

COMMIT TRANSACTION;
SET out_param  =  'geänderte Zuordnung gespeichert';
SELECT out_param;
RETURN;
END;