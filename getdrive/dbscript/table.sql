-- 자동생성 스크립트이므로 꼭, 내용을 확인할 것.
-- 변경시 변경버전 추가하고 수정내용 아래와 작성할 것.
-- 트리거 4개를 한번에 실행시 오류가 확인됨. 삭제함.
/*
	ver 0.5 / 김영활 / 2024.03.29
                : 검색테이블 칼럼 추가 및 트리거 4개 삭제

	ver 0.4 / 홍은비 / 2024.03.27
		: 4-1. 카테고리 테이블 CT_NAME 컬럼 추가
		: 10. INSERT문 추가	

	ver 0.3 / 전상우 / 2024.03.25
		: 4-4 Board File 삭제

	ver 0.2 / 김민식 / 2024.03.21
		: edate, odate, reader 등 오타 수정

	ver 0.1 / 김영활 / 2024.03.19
		: 최초 작성
*/



-- 1. 기존테이블 삭제
DROP TABLE TB_MEMBER CASCADE CONSTRAINTS;
DROP TABLE TB_TEAM CASCADE CONSTRAINTS;
DROP TABLE TB_TEAM_USER CASCADE CONSTRAINTS;

DROP TABLE TB_CATEGORY CASCADE CONSTRAINTS;
DROP TABLE TB_BOARD CASCADE CONSTRAINTS;
DROP TABLE TB_BOARD_COMMENT CASCADE CONSTRAINTS;
DROP TABLE TB_BOARD_FILE CASCADE CONSTRAINTS;

DROP TABLE TB_CHAT CASCADE CONSTRAINTS;
DROP TABLE TB_CHATROOMUSER CASCADE CONSTRAINTS;
DROP TABLE TB_CHATCONTENT CASCADE CONSTRAINTS;
DROP TABLE TB_CHATREPLY CASCADE CONSTRAINTS;
DROP TABLE TB_CHATFILE CASCADE CONSTRAINTS;

DROP TABLE TB_DRIVE CASCADE CONSTRAINTS;
DROP TABLE TB_DRIVE_FOLDER CASCADE CONSTRAINTS;
DROP TABLE TB_DRIVE_FILE CASCADE CONSTRAINTS;

DROP TABLE TB_CALENDER CASCADE CONSTRAINTS;

DROP TABLE TB_ALARM CASCADE CONSTRAINTS;
DROP TABLE TB_ALARM_CHECK CASCADE CONSTRAINTS;

DROP TABLE TB_SEARCH CASCADE CONSTRAINTS;


-- 2. 회원 테이블
CREATE TABLE TB_MEMBER 
(	
	M_NO NUMBER NOT NULL, 
	M_NAME VARCHAR2(20 BYTE) NOT NULL, 
	M_EMAIL VARCHAR2(20 BYTE) NOT NULL, 
	M_PASSWD VARCHAR2(20 BYTE) NOT NULL, 
	M_EDATE DATE NOT NULL, 
	M_ODATE DATE, 
	CONSTRAINT TB_MEMBER_PK PRIMARY KEY (M_NO)
);

COMMENT ON COLUMN TB_MEMBER.M_NO IS '고유번호';
COMMENT ON COLUMN TB_MEMBER.M_NAME IS '이름';
COMMENT ON COLUMN TB_MEMBER.M_EMAIL IS '이메일(아이디)';
COMMENT ON COLUMN TB_MEMBER.M_PASSWD IS '비밀번호';
COMMENT ON COLUMN TB_MEMBER.M_EDATE IS '가입일';
COMMENT ON COLUMN TB_MEMBER.M_ODATE IS '탈퇴일';


-- 3-1. 팀 테이블
CREATE TABLE TB_TEAM
(	
	T_NO NUMBER NOT NULL, 
	T_MID NUMBER NOT NULL, 
	T_NAME VARCHAR2(20 BYTE), 
	T_CDATE DATE, 
	CONSTRAINT TB_TEAM_PK PRIMARY KEY (T_NO), 
	CONSTRAINT TB_TEAM_FK1 FOREIGN KEY (T_MID) REFERENCES TB_MEMBER (M_NO)
);

COMMENT ON COLUMN TB_TEAM.T_NO IS '팀 고유번호';
COMMENT ON COLUMN TB_TEAM.T_MID IS '팀장, 회원 고유번호';
COMMENT ON COLUMN TB_TEAM.T_NAME IS '팀명';
COMMENT ON COLUMN TB_TEAM.T_CDATE IS '팀 개설일';


-- 3-2. 팀원 테이블
CREATE TABLE TB_TEAM_USER 
(	
	TU_TID NUMBER NOT NULL, 
	TU_MID NUMBER NOT NULL, 
	TU_EDATE DATE NOT NULL, 
	TU_ODATE DATE, 
	TU_LEADER CHAR(1 BYTE) DEFAULT 'N' NOT NULL, 
	TU_NAME VARCHAR2(20 BYTE) NOT NULL, 
	CONSTRAINT TB_TEAM_USER_PK PRIMARY KEY (TU_TID, TU_MID), 
	CONSTRAINT TB_TEAM_USER_FK1 FOREIGN KEY (TU_TID) REFERENCES TB_TEAM (T_NO), 
	CONSTRAINT TB_TEAM_USER_FK2 FOREIGN KEY (TU_MID) REFERENCES TB_MEMBER (M_NO)
);

COMMENT ON COLUMN TB_TEAM_USER.TU_TID IS '팀 고유번호';
COMMENT ON COLUMN TB_TEAM_USER.TU_MID IS '회원 고유번호';
COMMENT ON COLUMN TB_TEAM_USER.TU_EDATE IS '팀 가입일';
COMMENT ON COLUMN TB_TEAM_USER.TU_ODATE IS '팀 탈퇴일';
COMMENT ON COLUMN TB_TEAM_USER.TU_LEADER IS '팀 리더여부';
COMMENT ON COLUMN TB_TEAM_USER.TU_NAME IS '팀원명';


-- 4-1. 카테고리 테이블
CREATE TABLE TB_CATEGORY 
(	
	CT_NO NUMBER NOT NULL, 
	CT_NAME VARCHAR2(20 BYTE) NOT NULL, 
	CT_REGDATE DATE NOT NULL, 
	CT_CRUID NUMBER NOT NULL, 
	CT_TID NUMBER NOT NULL, 
	CONSTRAINT TB_CATEGORY_PK PRIMARY KEY (CT_NO, CT_TID), 
	CONSTRAINT TB_CATEGORY_FK1 FOREIGN KEY (CT_TID, CT_CRUID) REFERENCES TB_TEAM_USER (TU_TID, TU_MID)
);

COMMENT ON COLUMN TB_CATEGORY.CT_NO IS '카테고리 고유번호';
COMMENT ON COLUMN TB_CATEGORY.CT_NAME IS '카테고리 이름';
COMMENT ON COLUMN TB_CATEGORY.CT_REGDATE IS '카테고리 생성일';
COMMENT ON COLUMN TB_CATEGORY.CT_CRUID IS '카테고리 개설자 회원 고유번호';
COMMENT ON COLUMN TB_CATEGORY.CT_TID IS '팀 고유번호';


-- 4-2. 게시물 테이블
CREATE TABLE TB_BOARD
(	
	B_NO NUMBER NOT NULL, 
	B_TITLE VARCHAR2(200 BYTE) NOT NULL, 
	B_CONTENT VARCHAR2(4000 BYTE) NOT NULL, 
	B_CRUID NUMBER NOT NULL, 
	B_NAME VARCHAR2(50 BYTE) NOT NULL, 
	B_ID VARCHAR2(200 BYTE) NOT NULL, 
	B_CDATE DATE NOT NULL, 
	B_UDATE DATE, 
	B_CTID NUMBER NOT NULL, 
	B_TID NUMBER NOT NULL, 
	CONSTRAINT TB_BOARD_PK PRIMARY KEY (B_TID, B_CTID, B_NO), 
	CONSTRAINT TB_BOARD_FK1 FOREIGN KEY (B_CTID, B_TID) REFERENCES TB_CATEGORY (CT_NO, CT_TID), 
	CONSTRAINT TB_BOARD_FK2 FOREIGN KEY (B_TID, B_CRUID) REFERENCES TB_TEAM_USER (TU_TID, TU_MID), 
	CONSTRAINT TB_BOARD_FK3 FOREIGN KEY (B_TID) REFERENCES TB_TEAM (T_NO)
);

COMMENT ON COLUMN TB_BOARD.B_NO IS '게시물 고유번호';
COMMENT ON COLUMN TB_BOARD.B_TITLE IS '게시물 제목';
COMMENT ON COLUMN TB_BOARD.B_CONTENT IS '게시물 내용';
COMMENT ON COLUMN TB_BOARD.B_CRUID IS '게시물 작성자의 고유번호';
COMMENT ON COLUMN TB_BOARD.B_NAME IS '게시물 작성자의 이름';
COMMENT ON COLUMN TB_BOARD.B_ID IS '게시물 작성자의 아이디';
COMMENT ON COLUMN TB_BOARD.B_CDATE IS '게시물 생성일';
COMMENT ON COLUMN TB_BOARD.B_UDATE IS '게시물 수정일';
COMMENT ON COLUMN TB_BOARD.B_CTID IS '카테고리 고유번호';
COMMENT ON COLUMN TB_BOARD.B_TID IS '팀 고유번호';


-- 4-3. 댓글 테이블
CREATE TABLE TB_BOARD_COMMENT
(	
	BC_NO NUMBER NOT NULL, 
	BC_CONTENT VARCHAR2(20 BYTE) NOT NULL, 
	BC_CDATE DATE NOT NULL, 
	BC_UDATE DATE NOT NULL, 
	BC_CRUID NUMBER NOT NULL, 
	BC_BID NUMBER NOT NULL, 
	BC_BCID NUMBER NOT NULL, 
	BC_TID NUMBER NOT NULL, 
	CONSTRAINT TB_BOARD_COMMENT_PK PRIMARY KEY (BC_NO, BC_BID, BC_BCID, BC_TID), 
	CONSTRAINT TB_BOARD_COMMENT_FK1 FOREIGN KEY (BC_TID, BC_CRUID) REFERENCES TB_TEAM_USER (TU_TID, TU_MID), 
	CONSTRAINT TB_BOARD_COMMENT_FK2 FOREIGN KEY (BC_TID, BC_BCID, BC_BID) REFERENCES TB_BOARD (B_TID, B_CTID, B_NO)
);

COMMENT ON COLUMN TB_BOARD_COMMENT.BC_NO IS '댓글 고유번호';
COMMENT ON COLUMN TB_BOARD_COMMENT.BC_CONTENT IS '댓글 내용';
COMMENT ON COLUMN TB_BOARD_COMMENT.BC_CDATE IS '댓글 등록일';
COMMENT ON COLUMN TB_BOARD_COMMENT.BC_UDATE IS '댓글 수정일';
COMMENT ON COLUMN TB_BOARD_COMMENT.BC_CRUID IS '댓글 등록자,  팀원 고유번호';
COMMENT ON COLUMN TB_BOARD_COMMENT.BC_BID IS '게시물고유번호';
COMMENT ON COLUMN TB_BOARD_COMMENT.BC_BCID IS '상위댓글 고유번호';
COMMENT ON COLUMN TB_BOARD_COMMENT.BC_TID IS '팀 고유번호';

-- 5-1. 챗팅방 테이블
CREATE TABLE TB_CHAT 
(	
	C_NO NUMBER NOT NULL, 
	C_NAME VARCHAR2(100 BYTE) NOT NULL, 
	C_DESC VARCHAR2(600 BYTE), 
	C_CDATE DATE NOT NULL, 
	C_CRUID NUMBER NOT NULL, 
	C_TID NUMBER NOT NULL, 
	CONSTRAINT TB_CHAT_PK PRIMARY KEY (C_NO, C_TID), 
	CONSTRAINT TB_CHAT_FK1 FOREIGN KEY (C_TID) REFERENCES TB_TEAM (T_NO), 
	CONSTRAINT TB_CHAT_FK2 FOREIGN KEY (C_TID, C_CRUID) REFERENCES TB_TEAM_USER (TU_TID, TU_MID)
);

COMMENT ON COLUMN TB_CHAT.C_NO IS '채팅방 고유번호';
COMMENT ON COLUMN TB_CHAT.C_NAME IS '채팅방명';
COMMENT ON COLUMN TB_CHAT.C_DESC IS '채팅방 설명';
COMMENT ON COLUMN TB_CHAT.C_CDATE IS '채팅방 개설일';
COMMENT ON COLUMN TB_CHAT.C_CRUID IS '채팅방 개설자 고유번호';
COMMENT ON COLUMN TB_CHAT.C_TID IS '팀 고유번호';


-- 5-2. 챗팅방 구성원 테이블
CREATE TABLE TB_CHATROOMUSER
(	
	CU_NO NUMBER NOT NULL, 
	CU_NAME VARCHAR2(20 BYTE) NOT NULL, 
	CU_CRU CHAR(1 BYTE) DEFAULT 'N' NOT NULL, 
	CU_EDATE DATE NOT NULL, 
	CU_CID NUMBER NOT NULL, 
	CU_TID NUMBER NOT NULL, 
	CONSTRAINT TB_CHATROOMUSER_PK PRIMARY KEY (CU_NO, CU_TID, CU_CID), 
	CONSTRAINT TB_CHATROOMUSER_FK2 FOREIGN KEY (CU_TID, CU_CID) REFERENCES TB_TEAM_USER (TU_TID, TU_MID), 
	CONSTRAINT TB_CHATROOMUSER_FK1 FOREIGN KEY (CU_TID) REFERENCES TB_TEAM (T_NO), 
	CONSTRAINT TB_CHATROOMUSER_FK3 FOREIGN KEY (CU_CID, CU_TID) REFERENCES TB_CHAT (C_NO, C_TID)
);

COMMENT ON COLUMN TB_CHATROOMUSER.CU_NO IS '채팅방 구성원 고유번호';
COMMENT ON COLUMN TB_CHATROOMUSER.CU_NAME IS '구성원 이름';
COMMENT ON COLUMN TB_CHATROOMUSER.CU_CRU IS '개설자 여부';
COMMENT ON COLUMN TB_CHATROOMUSER.CU_EDATE IS '입장일자';
COMMENT ON COLUMN TB_CHATROOMUSER.CU_CID IS '채팅방 고유번호';
COMMENT ON COLUMN TB_CHATROOMUSER.CU_TID IS '팀 고유번호';


-- 5-3. 챗팅내용 테이블
CREATE TABLE TB_CHATCONTENT 
(	
	CC_NO NUMBER NOT NULL, 
	CC_CONTENT VARCHAR2(2000 BYTE) NOT NULL, 
	CC_CDATE DATE NOT NULL, 
	CC_NOTICE CHAR(1 BYTE) DEFAULT 'N' NOT NULL, 
	CC_CRUID NUMBER NOT NULL, 
	CC_CID NUMBER NOT NULL, 
	CC_TID NUMBER NOT NULL, 
	CONSTRAINT TB_CHATCONTENT_PK PRIMARY KEY (CC_NO, CC_CID, CC_TID), 
	CONSTRAINT TB_CHATCONTENT_FK1 FOREIGN KEY (CC_CID, CC_TID) REFERENCES TB_CHAT (C_NO, C_TID), 
	CONSTRAINT TB_CHATCONTENT_FK2 FOREIGN KEY (CC_TID, CC_CRUID) REFERENCES TB_TEAM_USER (TU_TID, TU_MID)
);

COMMENT ON COLUMN TB_CHATCONTENT.CC_NO IS '채팅 고유번호';
COMMENT ON COLUMN TB_CHATCONTENT.CC_CONTENT IS '채팅 내용';
COMMENT ON COLUMN TB_CHATCONTENT.CC_CDATE IS '작성일자';
COMMENT ON COLUMN TB_CHATCONTENT.CC_NOTICE IS '공지여부';
COMMENT ON COLUMN TB_CHATCONTENT.CC_CRUID IS '작성자 고유번호';
COMMENT ON COLUMN TB_CHATCONTENT.CC_CID IS '채팅방 고유번호';
COMMENT ON COLUMN TB_CHATCONTENT.CC_TID IS '팀 고유번호';


-- 5-4. 챗팅답글 테이블
CREATE TABLE TB_CHATREPLY
(	
	CR_NO VARCHAR2(20 BYTE) NOT NULL, 
	CR_RECONTENT VARCHAR2(4000 BYTE) NOT NULL, 
	CR_CRUID NUMBER NOT NULL, 
	CR_CDATE DATE NOT NULL, 
	CR_UDATE DATE NOT NULL, 
	CR_CCID NUMBER NOT NULL, 
	CR_CID NUMBER NOT NULL, 
	CR_TID NUMBER NOT NULL, 
	CONSTRAINT TB_CHATREPLY_PK PRIMARY KEY (CR_TID, CR_CID, CR_CCID, CR_NO), 
	CONSTRAINT TB_CHATREPLY_FK3 FOREIGN KEY (CR_CCID, CR_CID, CR_TID) REFERENCES TB_CHATCONTENT (CC_NO, CC_CID, CC_TID)
);

COMMENT ON COLUMN TB_CHATREPLY.CR_NO IS '답글 고유번호';
COMMENT ON COLUMN TB_CHATREPLY.CR_RECONTENT IS '답글 내용';
COMMENT ON COLUMN TB_CHATREPLY.CR_CRUID IS '답글 작성자 고유번호';
COMMENT ON COLUMN TB_CHATREPLY.CR_CDATE IS '답글 등록일';
COMMENT ON COLUMN TB_CHATREPLY.CR_UDATE IS '답글 수정일';
COMMENT ON COLUMN TB_CHATREPLY.CR_CCID IS '채팅내용 고유번호';
COMMENT ON COLUMN TB_CHATREPLY.CR_CID IS '채팅방 고유번호';
COMMENT ON COLUMN TB_CHATREPLY.CR_TID IS '팀 고유번호';

-- 6-1. 드라이브 테이블
CREATE TABLE TB_DRIVE 
(	
	D_NO NUMBER NOT NULL, 
	D_NAME VARCHAR2(50 BYTE) NOT NULL, 
	D_CDATE DATE NOT NULL, 
	D_UDATE DATE, 
	D_PUB CHAR(1 BYTE) DEFAULT 'Y' NOT NULL, 
	D_TRCAN CHAR(1 BYTE) DEFAULT 'N' NOT NULL, 
	D_CRUID NUMBER NOT NULL, 
	D_TID NUMBER NOT NULL, 
	CONSTRAINT TB_DRIVE_PK PRIMARY KEY (D_TID, D_NO), 
	CONSTRAINT TB_DRIVE_FK1 FOREIGN KEY (D_TID, D_CRUID) REFERENCES TB_TEAM_USER (TU_TID, TU_MID), 
	CONSTRAINT TB_DRIVE_FK2 FOREIGN KEY (D_TID) REFERENCES TB_TEAM (T_NO)
);

COMMENT ON COLUMN TB_DRIVE.D_NO IS '드라이브 고유번호';
COMMENT ON COLUMN TB_DRIVE.D_NAME IS '드라이브명';
COMMENT ON COLUMN TB_DRIVE.D_CDATE IS '생성일';
COMMENT ON COLUMN TB_DRIVE.D_UDATE IS '수정일';
COMMENT ON COLUMN TB_DRIVE.D_PUB IS '공개여부';
COMMENT ON COLUMN TB_DRIVE.D_TRCAN IS '휴지통 여부';
COMMENT ON COLUMN TB_DRIVE.D_CRUID IS '생성자 고유번호';
COMMENT ON COLUMN TB_DRIVE.D_TID IS '팀 고유번호';


-- 6-2. 폴더 테이블
CREATE TABLE TB_DRIVE_FOLDER
(	
	FD_NO NUMBER NOT NULL, 
	FD_NAME VARCHAR2(50 BYTE), 
	FD_CDATE DATE, 
	FD_UDATE DATE, 
	FD_CRUID NUMBER NOT NULL, 
	FD_DID NUMBER NOT NULL, 
	FD_TID NUMBER NOT NULL, 
	CONSTRAINT TB_DRIVE_FOLDER_PK PRIMARY KEY (FD_NO, FD_DID, FD_TID), 
	CONSTRAINT TB_DRIVE_FOLDER_FK1 FOREIGN KEY (FD_TID, FD_DID) REFERENCES TB_DRIVE (D_TID, D_NO), 
	CONSTRAINT TB_DRIVE_FOLDER_FK2 FOREIGN KEY (FD_TID, FD_CRUID) REFERENCES TB_TEAM_USER (TU_TID, TU_MID)
);

COMMENT ON COLUMN TB_DRIVE_FOLDER.FD_NO IS '폴더 고유번호';
COMMENT ON COLUMN TB_DRIVE_FOLDER.FD_NAME IS '폴더명';
COMMENT ON COLUMN TB_DRIVE_FOLDER.FD_CDATE IS '생성일';
COMMENT ON COLUMN TB_DRIVE_FOLDER.FD_UDATE IS '수정일';
COMMENT ON COLUMN TB_DRIVE_FOLDER.FD_CRUID IS '생성자 고유번호';
COMMENT ON COLUMN TB_DRIVE_FOLDER.FD_DID IS '드라이브 고유번호';
COMMENT ON COLUMN TB_DRIVE_FOLDER.FD_TID IS '팀 고유번호';


-- 6-3. 파일 테이블
CREATE TABLE TB_DRIVE_FILE 
(	
	FL_NO NUMBER NOT NULL, 
	FL_NAME VARCHAR2(50 BYTE) NOT NULL, 
	FL_EXT CHAR(3 BYTE) NOT NULL, 
	FL_LOC VARCHAR2(100 BYTE) NOT NULL, 
	FL_SIZE NUMBER NOT NULL, 
	FL_CDATE DATE NOT NULL, 
	FL_UDATE DATE, 
	FL_CRUID NUMBER NOT NULL, 
	FL_FDID NUMBER NOT NULL, 
	FL_DID NUMBER NOT NULL, 
	FL_TID NUMBER NOT NULL, 
	CONSTRAINT TB_DRIVE_FILE_PK PRIMARY KEY (FL_NO, FL_DID, FL_TID), 
	CONSTRAINT TB_DRIVE_FILE_FK1 FOREIGN KEY (FL_TID, FL_DID) REFERENCES TB_DRIVE (D_TID, D_NO), 
	CONSTRAINT TB_DRIVE_FILE_FK2 FOREIGN KEY (FL_TID, FL_CRUID) REFERENCES TB_TEAM_USER (TU_TID, TU_MID), 
	CONSTRAINT TB_DRIVE_FILE_FK3 FOREIGN KEY (FL_FDID, FL_DID, FL_TID) REFERENCES TB_DRIVE_FOLDER (FD_NO, FD_DID, FD_TID)
);

COMMENT ON COLUMN TB_DRIVE_FILE.FL_NO IS '파일 고유번호';
COMMENT ON COLUMN TB_DRIVE_FILE.FL_NAME IS '파일명';
COMMENT ON COLUMN TB_DRIVE_FILE.FL_EXT IS '파일확장자명';
COMMENT ON COLUMN TB_DRIVE_FILE.FL_LOC IS '저장위치';
COMMENT ON COLUMN TB_DRIVE_FILE.FL_SIZE IS '파일크기';
COMMENT ON COLUMN TB_DRIVE_FILE.FL_CDATE IS '생성일';
COMMENT ON COLUMN TB_DRIVE_FILE.FL_UDATE IS '수정일';
COMMENT ON COLUMN TB_DRIVE_FILE.FL_CRUID IS '생성자 고유번호';
COMMENT ON COLUMN TB_DRIVE_FILE.FL_FDID IS '폴더 고유번호';
COMMENT ON COLUMN TB_DRIVE_FILE.FL_DID IS '드라이브 고유번호';
COMMENT ON COLUMN TB_DRIVE_FILE.FL_TID IS '팀 고유번호';


-- 7. 캘린더 테이블
CREATE TABLE TB_CALENDER
(	
	CL_NO NUMBER NOT NULL, 
	CL_DATE VARCHAR2(20 BYTE) NOT NULL, 
	CL_START VARCHAR2(20 BYTE) NOT NULL, 
	CL_END VARCHAR2(20 BYTE) NOT NULL, 
	CL_TITLE VARCHAR2(20 BYTE) NOT NULL, 
	CL_CONTENT VARCHAR2(20 BYTE) NOT NULL, 
	CL_CDATE VARCHAR2(20 BYTE) NOT NULL, 
	CL_UDATE VARCHAR2(20 BYTE) NOT NULL, 
	CL_CHECK VARCHAR2(20 BYTE) NOT NULL, 
	CL_CRUID NUMBER NOT NULL, 
	CL_XPOINT VARCHAR2(20 BYTE) NOT NULL, 
	CL_YPOINT VARCHAR2(20 BYTE) NOT NULL, 
	CL_TID NUMBER NOT NULL, 
	CONSTRAINT TB_CALENDER_PK PRIMARY KEY (CL_NO, CL_TID), 
	CONSTRAINT TB_CALENDER_FK1 FOREIGN KEY (CL_TID) REFERENCES TB_TEAM (T_NO), 
	CONSTRAINT TB_CALENDER_FK2 FOREIGN KEY (CL_TID, CL_CRUID) REFERENCES TB_TEAM_USER (TU_TID, TU_MID)
);

COMMENT ON COLUMN TB_CALENDER.CL_NO IS '캘린더 고유번호';
COMMENT ON COLUMN TB_CALENDER.CL_DATE IS '캘린더 일자';
COMMENT ON COLUMN TB_CALENDER.CL_START IS '캘린더 시작시간';
COMMENT ON COLUMN TB_CALENDER.CL_END IS '캘린더 종료시간';
COMMENT ON COLUMN TB_CALENDER.CL_TITLE IS '캘린더 제목';
COMMENT ON COLUMN TB_CALENDER.CL_CONTENT IS '캘린더 내용';
COMMENT ON COLUMN TB_CALENDER.CL_CDATE IS '캘린더 등록일';
COMMENT ON COLUMN TB_CALENDER.CL_UDATE IS '캘린더 수정일';
COMMENT ON COLUMN TB_CALENDER.CL_CHECK IS '캘린더 공개여부';
COMMENT ON COLUMN TB_CALENDER.CL_CRUID IS '작성자 고유번호';
COMMENT ON COLUMN TB_CALENDER.CL_XPOINT IS '캘린더 좌표(위도)';
COMMENT ON COLUMN TB_CALENDER.CL_YPOINT IS '캘린더 좌표(경도)';
COMMENT ON COLUMN TB_CALENDER.CL_TID IS '팀 고유번호';


-- 8-1. 알람 테이블
CREATE TABLE TB_ALARM
(	
	A_NO NUMBER NOT NULL, 
	A_MENU VARCHAR2(20 BYTE) NOT NULL, 
	A_TITLE VARCHAR2(200 BYTE) NOT NULL, 
	A_CONTENT VARCHAR2(4000 BYTE), 
	A_DATE DATE NOT NULL, 
	A_CRUID NUMBER NOT NULL, 
	A_ID NUMBER NOT NULL, 
	A_TID NUMBER NOT NULL, 
	CONSTRAINT TB_ALARM_PK PRIMARY KEY (A_NO, A_TID), 
	CONSTRAINT TB_ALARM_FK1 FOREIGN KEY (A_TID) REFERENCES TB_TEAM (T_NO), 
	CONSTRAINT TB_ALARM_FK2 FOREIGN KEY (A_TID, A_CRUID) REFERENCES TB_TEAM_USER (TU_TID, TU_MID)
);

COMMENT ON COLUMN TB_ALARM.A_NO IS '알람 고유번호';
COMMENT ON COLUMN TB_ALARM.A_MENU IS '구분 게시물 카테고리/채팅/드라이브/캘린더';
COMMENT ON COLUMN TB_ALARM.A_TITLE IS '제목 or 파일명';
COMMENT ON COLUMN TB_ALARM.A_CONTENT IS '내용';
COMMENT ON COLUMN TB_ALARM.A_DATE IS '등록자 고유번호';
COMMENT ON COLUMN TB_ALARM.A_CRUID IS '등록일 or 수정일';
COMMENT ON COLUMN TB_ALARM.A_ID IS '원 게시물의 고유번호';
COMMENT ON COLUMN TB_ALARM.A_TID IS '팀 고유번호';


-- 8-2. 알람확인인원 테이블
CREATE TABLE TB_ALARM_CHECK 
(	
	AC_NO NUMBER NOT NULL, 
	AC_AID NUMBER NOT NULL, 
	AC_CDATE DATE NOT NULL, 
	AC_UID NUMBER NOT NULL, 
	AC_TID NUMBER NOT NULL, 
	CONSTRAINT TB_ALARM_CHECK_PK PRIMARY KEY (AC_NO, AC_TID), 
	CONSTRAINT TB_ALARM_CHECK_FK2 FOREIGN KEY (AC_AID, AC_TID) REFERENCES TB_ALARM (A_NO, A_TID), 
    CONSTRAINT TB_ALARM_CHECK_FK1 FOREIGN KEY (AC_TID, AC_UID) REFERENCES TB_TEAM_USER (TU_TID, TU_MID)
);

COMMENT ON COLUMN TB_ALARM_CHECK.AC_NO IS '고유번호';
COMMENT ON COLUMN TB_ALARM_CHECK.AC_AID IS '원알람 고유번호';
COMMENT ON COLUMN TB_ALARM_CHECK.AC_CDATE IS '알람 확인일자';
COMMENT ON COLUMN TB_ALARM_CHECK.AC_UID IS '팀원 고유번호';
COMMENT ON COLUMN TB_ALARM_CHECK.AC_TID IS '팀 고유번호';

-- 9. 통합검색 테이블 : 2024.03.29 김영활 수정
  CREATE TABLE "TB_SEARCH" 
   (	"S_NO" NUMBER NOT NULL ENABLE, 
	"S_MENU" VARCHAR2(20 BYTE) NOT NULL ENABLE, 
	"S_TITLE" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	"S_CONTENT" VARCHAR2(4000 BYTE), 
	"S_DATE" DATE NOT NULL ENABLE, 
	"S_CRUID" NUMBER NOT NULL ENABLE, 
	"S_ID" NUMBER NOT NULL ENABLE, 
	"S_CTID" NUMBER NOT NULL ENABLE, 
	"S_TID" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "TB_SEARCH_PK" PRIMARY KEY ("S_NO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

   COMMENT ON COLUMN "TB_SEARCH"."S_NO" IS '알람 고유번호';
   COMMENT ON COLUMN "TB_SEARCH"."S_MENU" IS '구분 게시물 카테고리/채팅/드라이브/캘린더';
   COMMENT ON COLUMN "TB_SEARCH"."S_TITLE" IS '제목 or 파일명';
   COMMENT ON COLUMN "TB_SEARCH"."S_CONTENT" IS '내용';
   COMMENT ON COLUMN "TB_SEARCH"."S_DATE" IS '등록일 or 수정일';
   COMMENT ON COLUMN "TB_SEARCH"."S_CRUID" IS '등록자 고유번호';
   COMMENT ON COLUMN "TB_SEARCH"."S_ID" IS '원 게시물의 고유번호';
   COMMENT ON COLUMN "TB_SEARCH"."S_CTID" IS '카테고리';
   COMMENT ON COLUMN "TB_SEARCH"."S_TID" IS '팀 고유번호';


-- 10. INSERT문 (샘플 데이터)
-- 10-1. 멤버
INSERT INTO TB_MEMBER VALUES(1, '김민식', 'aaa123@naver.com', '123', sysdate, null);
INSERT INTO TB_MEMBER VALUES((select max(m_no) + 1 from tb_member), '홍은비', 'bbb123@naver.com', '123', sysdate, null);
INSERT INTO TB_MEMBER VALUES((select max(m_no) + 1 from tb_member), '전상우', 'ccc123@naver.com', '123', sysdate, null);
INSERT INTO TB_MEMBER VALUES((select max(m_no) + 1 from tb_member), '김영활', 'ddd123@naver.com', '123', sysdate, null);
INSERT INTO TB_MEMBER VALUES((select max(m_no) + 1 from tb_member), '이승철', 'eee123@naver.com', '123', sysdate, null);
INSERT INTO TB_MEMBER VALUES((select max(m_no) + 1 from tb_member), '신예담', 'fff123@naver.com', '123', sysdate, null);

-- 10-2. 팀
INSERT INTO TB_TEAM VALUES(1, 1, 'get.drive', sysdate);
INSERT INTO TB_TEAM VALUES((select max(t_mid) + 1 from tb_team), 2, 'team2', sysdate);
INSERT INTO TB_TEAM VALUES((select max(t_mid) + 1 from tb_team), 3, 'ict_dev', sysdate);

-- 10-3. 팀원 
INSERT INTO TB_TEAM_USER VALUES(1, 1, sysdate, null, 'Y', '김민식');
INSERT INTO TB_TEAM_USER VALUES(1, 2, sysdate, null, 'N', '홍은비');
INSERT INTO TB_TEAM_USER VALUES(1, 3, sysdate, null, 'N', '전상우');
INSERT INTO TB_TEAM_USER VALUES(2, 4, sysdate, null, 'Y', '김영활');
INSERT INTO TB_TEAM_USER VALUES(2, 5, sysdate, null, 'N', '이승철');
INSERT INTO TB_TEAM_USER VALUES(2, 6, sysdate, null, 'N', '신예담');

-- 10-3. 카테고리 *** 값 입력이 안됨 (부모키 없음) ***
INSERT INTO TB_CATEGORY VALUES(1, '공지사항', sysdate, 2, 1);
INSERT INTO TB_CATEGORY VALUES((select max(ct_no)  + 1 from tb_category), '자료방', sysdate, 3, 1);

-- 10-4. 게시물 *** 값 입력이 안됨 (부모키 없음) ***
INSERT INTO TB_BOARD VALUES(1, '게시물 제목1', '안녕하세요.', 3, '전상우', 'user03', sysdate, null, 1, 1);

-- 10-5. 댓글

-- 10-6. 채팅방

-- 10-7. 채팅방 구성원

-- 10-8. 채팅방 내용

-- 10-9. 채팅 답글

COMMIT;








