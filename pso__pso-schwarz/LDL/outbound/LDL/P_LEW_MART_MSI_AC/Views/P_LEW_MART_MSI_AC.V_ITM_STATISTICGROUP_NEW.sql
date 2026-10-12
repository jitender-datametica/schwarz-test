/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI_AC.V_ITM_STATISTICGROUP_NEW
#----------------------------------------------------------------------------
# History:
#  1.0  15.11.2017    Wieber.Harald            Release 1.1
#  1.1  24.01.2018    Wieber.Harald            Release 2.2.1
#  1.2  22.02.2018    Wieber.Harald            Update Release 2.3.4
#  1.3  01.03.2018    Wieber.Harald            Update to Release 3.0
#  1.4  03.04.2018    Wieber.Harald            Update 03.04.2018
#  1.5  03.05.2018    Wieber.Harald            Release 3.6
#  1.6  17.05.2018    Wieber,Harald            Update Release 3.8
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_itm_statisticgroup_new (statisticgroup_id OPTIONS(description='BNL'),
statisticgroup_desc OPTIONS(description='Statistk Bez. Einheit desc'), language_id
OPTIONS(description='Sprachencode; SAP-Retail: MAKT.SPRAS; SAP-BW: t_bw_0material_text.spras'), stdgroup_id
OPTIONS(description='Stdgrouk Bez. Einheit id')) OPTIONS(DESCRIPTION = `VIEW`) AS SELECT *
FROM ldl_p_lew_mart_msi.v_itm_statisticgroup_new;