/*
#-------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#
#  1.0 2023-04-19 Pawel Wieczorek         AP0157806 Initial version
#  1.1 2023-04-21 Marcin Kikola           Change in the list of pcwo reasons in order to allign with Mstr FE metrics' definitions
#  1.2 2023-09-12 Marcin Kikola           Change the condition for write-ffs to align with lead definition
#  1.3 2024-02-14 Marcin kikola           Rest PV - change of the definition of the metric. Additional PCWO reason was added
#  1.4 2027-04-25 Pawel Wieczorek         INC8314675_BGES_VGES_lidlplus limit to BGES
#  1.5 2027-04-25 Pawel Wieczorek         Changed condition bges.is_btes
#-------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_agg_store_day_item_sfo_ldpl_2 (client_id
OPTIONS(description='Landeskennzeichen'), loc_sid_store OPTIONS(description='Store id'), booking_dat
OPTIONS(description='MHD Profung beim Wareneingang bereits vorhanden'), item_sid
OPTIONS(description='Surrogate Key Item_2'), sfotype_id OPTIONS(description='Beleg-Typ'), pcwo_reason_id
OPTIONS(description='Eindeutige ID des Abschriften_2- bzw. PV-Grundes. Landesspezifische Abschriftengrunde haben ID > 100. - without PV'),
sfo_total_rtl_rl_net_val OPTIONS(description='NET final SFO amount mapped, according to column sfo_type_cd'),
dwh_updated OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'))
OPTIONS(DESCRIPTION = `WRITEOFF VALUES - SELECTED PCWO_REASON_ID FOR LIDLPLUS - IN LOCAL CURRENCY`) AS
/* limit to BGES data */ SELECT WO.client_id,
 WO.loc_sid_store,
 WO.booking_dat,
 WO.item_sid,
 WO.sfotype_id,
  CASE
  WHEN WO.pcwo_reason_id IN (6, 81, 151)
  THEN WO.pcwo_reason_id
  ELSE 0
  END AS pcwo_reason_id,
 WO.sfo_total_rtl_rl_net_val,
 WO.dwh_updated
FROM ldl_p_lew_bil.t_agg_store_day_item_sfo_2 AS WO
 INNER JOIN ldl_p_lew_mart_lidl_digital.v_moved_store_ldpl_2 AS BGES ON WO.client_id = BGES.client_id AND WO.loc_sid_store
    /* is_BGES == Y */ = BGES.store_id AND BGES.move_to_store_id > 0
WHERE WO.sfotype_id IN (182, 192) AND WO.pcwo_reason_id IN (21, 23, 24, 22, 126, 28, 27, 26, 132, 29, 31, 103, 104, 123
    , 124, 30, 105, 106, 107, 108, 109, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 125, 133, 25, 112, 138, 139,
    140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 153)
 OR WO.sfotype_id IN (137, 147) AND WO.pcwo_reason_id IN (2, 128, 1, 127, 134, 135, 5, 6, 3, 7, 130, 131, 4, 101, 102,
    110, 111, 129, 8, 136, 137, 151, 152)
 OR WO.sfotype_id IN (181, 191) AND WO.pcwo_reason_id IN (81, 82, 83, 84);