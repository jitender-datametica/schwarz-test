CREATE OR REPLACE VIEW dbp_msi_view_ios_materialized.mv_user_mandant_msiprodukt_zu_1 (user_id, mandant_id, loesch_fg) AS
SELECT user_id,
 mandant_id,
 MIN(loesch_fg) AS loesch_fg
FROM (SELECT V01.user_id,
    V02.mandant_id,
    '1' AS loesch_fg
   FROM kfl_production_dbp_security.l_msi_user_1 AS V01
    INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V02 ON TRUE
   WHERE V01.msi_produkt_bez = 'IOS'
   GROUP BY V01.user_id,
    V02.mandant_id,
    loesch_fg
   UNION DISTINCT
   SELECT user_id,
    mandant_id,
    '0' AS loesch_fg
   FROM kfl_production_dbp_security.user_mandant_msiprodukt_zu_1
   WHERE msi_produkt_bez = 'IOS') AS sub
GROUP BY user_id,
 mandant_id;