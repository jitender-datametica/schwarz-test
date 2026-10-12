CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_ANL_KL_KTO_SPR_ZU
(
	OBJEKTART_ID,
	ANL_KL_KTO_ID,
	ANL_KL_KTO_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 23.04.2013 twie: Anlageklasse und Kostenart für Pflegebericht in ein Attribut kombinieren
--                            View dient als Lookup im Pflegebericht zur Auswahl Anlageklassen und Kostenarten
-- 10.09.2013 AL nicht nummerische Anlageklassen und ANKL mit <> 8 Zeichen aufgenommen

   SELECT
   CAST('AKL' AS CHAR(3)) AS objektart_id,
   CAST('AKL:' || anlage_klasse_id AS VARCHAR(14)) AS anl_kl_kto_id,
   anlage_klasse_bez AS anl_kl_kto_bez
   FROM dbp_view.v_anlage_klasse_spr_zu
   WHERE  anlage_klasse_bez_kurz <> 'inaktiv'
   AND spr_id=22
   /*AND LENGTH ( TRIM ( LEADING '0' FROM
   TRIM ( BOTH FROM anlage_klasse_id)
   )
   ) = 8  */
   --and dbe_process.is_num(anlage_klasse_id) = 1

   QUALIFY ROW_NUMBER() OVER (PARTITION BY anlage_klasse_id ORDER BY mandant_id ASC) =1


   UNION


   SELECT
   CAST('KTO' AS CHAR(3)) AS objektart_id,
   CAST('KTO:' || kostenart_id AS VARCHAR(14)) AS anl_kl_kto_id,
   kostenart_bez  AS anl_kl_kto_bez
  FROM dbp_view.v_kostenart_spr_zu
  WHERE spr_id=22
  AND mandant_id = 1
  AND krk_id='XX01'
  ;