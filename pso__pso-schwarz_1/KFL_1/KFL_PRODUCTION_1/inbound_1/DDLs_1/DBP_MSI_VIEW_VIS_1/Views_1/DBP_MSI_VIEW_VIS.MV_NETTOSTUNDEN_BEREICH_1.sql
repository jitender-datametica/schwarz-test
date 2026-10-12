CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_NETTOSTUNDEN_BEREICH_1(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	DAT,
	DAT_ZEIT_AENDERUNG,
	HR_OBJEKT_BEREICH_ID,
	QUELLE_ID,
	STUNDEN_TYP_FG,
	STUNDEN_1,
	STD_IST,
	STD_PLAN,
	STUNDEN_IST,
	STUNDEN_PLAN,
	STUNDEN_SONST_IST,
	STUNDEN_SONST_PLAN,
	STUNDEN_CO_IST,
	STUNDEN_CO_PLAN
) AS

    -- FAKT : Stunden_1 Bereich pro Filiale/Tag_1
    -- Direktzugriff für Transaktion
    -- 2019.0703 ssch0611 : Initial - Sonstige (externe Stunden_1)
    -- 2019.0704 ssch0611 : Anpassung quelle_id
    -- 2019.1010 ssch0611 : Quelle: GFOS Excel < 2019-09-01 > GFOS Oracle
	  -- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]

SELECT
 nsb.mandant_id
 , wup.aktuell_wup_id 																											                                                AS wup_id
 , nsb.nb_id
 , nsb.dat
 , nsb.dat_zeit_aenderung
 , nsb.hr_objekt_bereich_id
 , nsb.quelle_id
 , nsb.stunden_typ_fg
 , nsb.stunden_1  -- ungefiltert
 , CASE WHEN stunden_typ_fg = 0 
   AND ((dat < CAST('2019-09-01' AS DATE) AND quelle_id <> 1) OR (dat >= CAST('2019-09-01' AS DATE) AND quelle_id <> 5)) 
   THEN stunden_1 
   ELSE 0.00 END 																												                                                    AS std_ist 				-- helper
 , CASE WHEN stunden_typ_fg = 1 
   AND ((dat < CAST('2019-09-01' AS DATE) AND quelle_id <> 1) OR (dat >= CAST('2019-09-01' AS DATE) AND quelle_id <> 5)) 
   THEN stunden_1 
   ELSE 0.00 END 																											  	                                                  AS std_plan 			-- helper
 , CASE WHEN nsb.quelle_id IN (1, 2, 3, 4, 5) 
   THEN std_ist  
   ELSE 0.00 END 																												                                                    AS stunden_ist
 , CASE WHEN nsb.quelle_id IN (1, 2, 3, 4, 5) 
   THEN std_plan 
   ELSE 0.00 END 																												                                                    AS stunden_plan
 , CASE WHEN nsb.quelle_id IN (9)             
   THEN std_ist  
   ELSE 0.00 END 																												                                                    AS stunden_sonst_ist
 , CASE WHEN nsb.quelle_id IN (9)             
   THEN std_plan 
    ELSE 0.00 END 																												                                                  AS stunden_sonst_plan
 , CASE WHEN nsb.quelle_id IN (6)             
   THEN std_ist  
   ELSE 0.00 END 																											                                                      AS stunden_co_ist
 , CASE WHEN nsb.quelle_id IN (6)               
   THEN std_plan 
   ELSE 0.00 END 																												                                                    AS stunden_co_plan
FROM dbp_view.v_nettostunden_bereich_1  nsb

INNER JOIN dbp_view.v_wup_1 wup_1
ON nsb.mandant_id = wup.mandant_id AND nsb.wup_id = wup.wup_id
;