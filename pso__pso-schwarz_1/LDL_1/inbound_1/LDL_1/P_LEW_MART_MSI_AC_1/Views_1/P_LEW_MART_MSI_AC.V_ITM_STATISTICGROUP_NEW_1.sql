/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI_AC.V_ITM_STATISTICGROUP_NEW_1
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

CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_ITM_STATISTICGROUP_NEW_1 COMMENT = 'View'
(
    statisticgroup_id        COMMENT 'BNL'
    ,statisticgroup_desc     COMMENT 'Statistk Bez. Einheit desc'
    ,language_id             COMMENT 'Sprachencode; SAP-Retail: MAKT.SPRAS; SAP-BW: t_bw_0material_text.spras'
    ,stdgroup_id             COMMENT 'Stdgrouk Bez. Einheit id'
) 

AS

SELECT
    statisticgroup_id
    , statisticgroup_desc
    , language_id
    , stdgroup_id
FROM P_LEW_MART_MSI.V_ITM_STATISTICGROUP_NEW_1 
;
