-- P_AUSLIEFERUNGSGRUPPE_ID STRING(10) ,

CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_ts_wbs_warengruppe_standard_add(IN P_MANDANT_ID BIGNUMERIC,
IN P_WG_ID BIGNUMERIC,
IN P_ESTIMATION_FG BIGNUMERIC,
IN P_ADJUSTMENT_FG BIGNUMERIC,
IN P_AUTO_BESTELLMENGE_MIT_BESTAND_PHASE_SWITCH_I_FG BIGNUMERIC,
IN P_AUTO_BESTELLMENGE_MIT_BESTAND_PHASE_SWITCH_III_FG BIGNUMERIC,
IN P_BONUSKAUF_PROMOTIONSTYP STRING,
OUT out_param STRING)

BEGIN
BEGIN TRANSACTION;

--:P_AUSLIEFERUNGSGRUPPE_ID AS AUSLIEFERUNGSGRUPPE_ID,
-- AND target.AUSLIEFERUNGSGRUPPE_ID = source.AUSLIEFERUNGSGRUPPE_ID
--AUSLIEFERUNGSGRUPPE_ID,
--source.AUSLIEFERUNGSGRUPPE_ID,

MERGE INTO dbp_msi_data.ts_wbs_warengruppe_standard_2 AS TARGET
USING (SELECT P_MANDANT_ID AS mandant_id,
 P_WG_ID AS wg_id,
 P_ESTIMATION_FG AS estimation_fg,
 P_ADJUSTMENT_FG AS adjustment_fg,
 P_AUTO_BESTELLMENGE_MIT_BESTAND_PHASE_SWITCH_I_FG AS auto_bestellmenge_mit_bestand_phase_switch_i_fg,
 P_AUTO_BESTELLMENGE_MIT_BESTAND_PHASE_SWITCH_III_FG AS auto_bestellmenge_mit_bestand_phase_switch_iii_fg,
 P_BONUSKAUF_PROMOTIONSTYP AS bonuskauf_promotionstyp) AS source
ON TARGET.mandant_id = source.mandant_id 
    AND TARGET.wg_id = source.wg_id 
    AND TARGET.bonuskauf_promotionstyp = source.bonuskauf_promotionstyp
WHEN MATCHED THEN UPDATE SET
    estimation_fg = CAST(source.estimation_fg AS INTEGER),
    adjustment_id = CAST(source.adjustment_fg AS INTEGER),
    auto_bestellmenge_mit_bestand_phase_switch_i_fg = CAST(source.auto_bestellmenge_mit_bestand_phase_switch_i_fg AS INTEGER),
    auto_bestellmenge_mit_bestand_phase_switch_iii_fg = CAST(source.auto_bestellmenge_mit_bestand_phase_switch_iii_fg AS INTEGER),
    bonuskauf_promotionstyp = CASE WHEN source.bonuskauf_promotionstyp = 'STANDARD' THEN '-1' ELSE source.bonuskauf_promotionstyp END,
    td_update = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT 
VALUES(CAST(source.mandant_id AS INTEGER),
 CAST(source.wg_id AS INTEGER),
 CAST(source.estimation_fg AS INTEGER),
 CAST(source.adjustment_fg AS INTEGER),
 CAST(source.auto_bestellmenge_mit_bestand_phase_switch_i_fg AS INTEGER),
 CAST(source.auto_bestellmenge_mit_bestand_phase_switch_iii_fg AS INTEGER),
 CASE WHEN source.bonuskauf_promotionstyp = 'STANDARD' THEN '-1' ELSE source.bonuskauf_promotionstyp END,
 CURRENT_TIMESTAMP(),
 CURRENT_TIMESTAMP());

COMMIT TRANSACTION;

SET out_param  =  'Freeze Writeback angepasst';
SELECT out_param;
RETURN;
END;