/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_BW_PALLETT_PRODUCTIVITY_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_bw_pallett_productivity_1 (client_id, iso_cd, cy_month, kpi_aspect, wh_id,
paletten_warenausgang, palettenleistung_lager, nettostunden_gesamt, paletten_wareneingang, palettenleistung_lager_aufgel
, wb_nettokolli, kilometer, nettostd_mitarbeiter_int, nettostd_mitarbeiter_ext, nettostd_gesamt_wb_retoure, kapazitaet,
paletten_warenausgang_up) AS SELECT *
FROM ldl_p_lew_mart_cs.v_bw_pallett_productivity_1;