CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_GINFO_BAUJAHR_1 AS
-- 06.05.2013 twie: Lookup für GINFO Baujahr (aus Bewegungsdaten plus Dummywert)

   SELECT
   DISTINCT(baujahr) AS baujahr,
   CAST(baujahr AS CHAR(4)) AS baujahr_bez

   FROM dbp_view.v_techn_platz_ebene_2_per_1

   UNION

   SELECT
   9999 AS baujahr,
   '' AS baujahr_bez

   FROM dbp_view.v_jahr_kj_1;