CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_L_AUFTRAGSART_2(
	AUFTRAGSART_ID,
	AUSFUHRENDER,
	TECHNIKBEREICH_BEZ
) AS
--2022-08-19, AP0133256,SPEC0166769,dknop, initial, copy from LIS + logic for Ausführender
--2023-02-03, AP0133256,SPEC0166769,dknop, adjust naming of 'Technikbereich'
--2023-05-12, dknop, moving CS35 , CS45  from Intern to Extern
   SELECT
    auftragsart_id
   ,CASE WHEN auftragsart_id IN ('CS37','CS47','CS57','CS77', 'CS35', 'CS45') THEN 'Extern'
         WHEN auftragsart_id IN ('CS34', 'CS44','CS36','CS46','CS56','CS76') THEN 'Intern'
         ELSE '' END AS ausfuhrender
   ,CASE WHEN auftragsart_id IN ('CS34', 'CS35') THEN 'FFZ Drittkunden'
         WHEN auftragsart_id IN ('CS36', 'CS37') THEN 'FFZ'
         WHEN auftragsart_id IN ('CS34', 'CS35') THEN 'FFZ Drittkunden'
         WHEN auftragsart_id IN ('CS44', 'CS45') THEN 'HT Drittkunden'
         WHEN auftragsart_id IN ('CS46', 'CS47') THEN 'HT'
         WHEN auftragsart_id IN ('CS55','CS56', 'CS57') THEN 'AT'
         WHEN auftragsart_id IN ('CS76', 'CS77') THEN 'Reinigung'
          ELSE '' END AS technikbereich_bez      
   FROM dbp_view.v_in_l_auftragsart_2
   --WHERE ausfuhrender<>''
   GROUP BY auftragsart_id 
   ;