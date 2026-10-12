/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL_AC.V_CAL_WEEK_PARTIAL_WEEK.
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# History:
#  1.0  15.09.2021    Syrokosz, Jaroslaw       First draft 
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_BIL_AC.V_CAL_WEEK_PARTIAL_WEEK_2
/*
#DescStart#
#$Revision: 62789 $, $LastChangedBy: jsyrokosz $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    cy_week_partial_week_id1
    , cy_week_partial_week_id2
    , cy_week_partial_week_name
    , cy_month
    , busyear
    , cy_week_partial_week_id
    , partialweek_in_mth_seq_asc
    , partialweek_in_mth_seq_desc
    , cy_partial_week_short_name
    , cy_partial_week_short_name_DE
    , cy_partial_week_short_name_EN
    , cy_partial_week_short_name_BG
    , cy_partial_week_short_name_CS
    , cy_partial_week_short_name_DA
    , cy_partial_week_short_name_EL
    , cy_partial_week_short_name_ES
    , cy_partial_week_short_name_FI
    , cy_partial_week_short_name_FR
    , cy_partial_week_short_name_HR
    , cy_partial_week_short_name_HU
    , cy_partial_week_short_name_IT
    , cy_partial_week_short_name_LT
    , cy_partial_week_short_name_NL
    , cy_partial_week_short_name_PL
    , cy_partial_week_short_name_PT
    , cy_partial_week_short_name_RO
    , cy_partial_week_short_name_SH
    , cy_partial_week_short_name_SK
    , cy_partial_week_short_name_SL
    , cy_partial_week_short_name_SV
) AS
SELECT 
    cy_week_partial_week_id1
    , cy_week_partial_week_id2
    , cy_week_partial_week_name
    , cy_month
    , busyear
    , cy_week_partial_week_id
    , partialweek_in_mth_seq_asc
    , partialweek_in_mth_seq_desc
    , cy_partial_week_short_name
    , cy_partial_week_short_name_DE
    , cy_partial_week_short_name_EN
    , cy_partial_week_short_name_BG
    , cy_partial_week_short_name_CS
    , cy_partial_week_short_name_DA
    , cy_partial_week_short_name_EL
    , cy_partial_week_short_name_ES
    , cy_partial_week_short_name_FI
    , cy_partial_week_short_name_FR
    , cy_partial_week_short_name_HR
    , cy_partial_week_short_name_HU
    , cy_partial_week_short_name_IT
    , cy_partial_week_short_name_LT
    , cy_partial_week_short_name_NL
    , cy_partial_week_short_name_PL
    , cy_partial_week_short_name_PT
    , cy_partial_week_short_name_RO
    , cy_partial_week_short_name_SH
    , cy_partial_week_short_name_SK
    , cy_partial_week_short_name_SL
    , cy_partial_week_short_name_SV
FROM P_LEW_BIL.V_CAL_WEEK_PARTIAL_WEEK_2
;