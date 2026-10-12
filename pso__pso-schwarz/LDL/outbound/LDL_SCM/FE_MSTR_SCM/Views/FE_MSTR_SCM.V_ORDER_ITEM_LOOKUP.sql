/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_AGG_SPACEMAN_KOP
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  01.01.2025	Akash Patil INITIAL SETUP
#  2.0  22.01.2025	Simeon Nikolaev Adding BUSYEAR
#
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_scm_fe_mstr_scm.v_order_item_lookup (ba_nr, client_id, busyear, ba_bezeichnung, ian,
artikel_bezeichnung, kolliinhalt, palfkt) AS SELECT DISTINCT WK_SUM.ba_nr,
 CLIENT.client_id,
 CAL.busyear,
 WK_SUM.ba_bezeichnung,
 WK_SUM.ian,
 WK_SUM.artikel_bezeichnung,
 WK_SUM.kolliinhalt,
 WK_SUM.palfkt
FROM ldl_scm_core.t_demand_ordr_recvd_weekly_sum AS WK_SUM
 INNER JOIN ldl_scm_core.v_client AS CLIENT ON WK_SUM.land = CLIENT.country_cd
 INNER JOIN ldl_scm_core_rel.v_busyear_month_week AS CAL ON WK_SUM.land = CAL.land AND WK_SUM.ba_nr = CAL.ba_nr AND
   WK_SUM.cal_month BETWEEN CAL.start_month AND CAL.end_month
WHERE WK_SUM.supplier_id_int IN (10390, 31838, 31982, 31837, 31839, -99)
 AND WK_SUM.bedarfsource NOT LIKE '%ELM%';