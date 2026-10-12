CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_MONAT_LETZTER_TAG_1
 (
   kj
   ,kjmo
   ,dat
 )
 AS
    SELECT
      kj,
    kjmo,
    MAX(dat) AS dat
    FROM dbp_view.v_tag_1
    WHERE dat <= CURRENT_DATE
      AND  kj >= (EXTRACT(YEAR FROM CURRENT_DATE) - 1)
    GROUP BY 1,2
 ;