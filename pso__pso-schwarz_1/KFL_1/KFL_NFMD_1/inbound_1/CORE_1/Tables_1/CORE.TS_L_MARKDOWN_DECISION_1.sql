CREATE TABLE CORE.TS_L_MARKDOWN_DECISION_1 (
    mandant_id NUMBER(5,0),
    markdown_decision_ID NUMBER(38, 0),
    markdown_decision VARCHAR(255),-- Deutsch / Default
    markdown_decision_bg VARCHAR(255),
    markdown_decision_cz VARCHAR(255),
    markdown_decision_en VARCHAR(255),
    markdown_decision_hr VARCHAR(255),
    markdown_decision_pl VARCHAR(255),
    markdown_decision_ro VARCHAR(255),
    markdown_decision_sk VARCHAR(255),
    markdown_decision_landessprache VARCHAR(255),
    flag_aktiv NUMBER(1,0),      
    flag_deaktiv NUMBER(1,0)    
);