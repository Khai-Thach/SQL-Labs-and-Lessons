CREATE TABLE HOTEL (
    HotelID         NUMBER PRIMARY KEY,
    HotelName       VARCHAR2(50)  UNIQUE NOT NULL,
    HotelAddress    VARCHAR2(50) NOT NULL,
    HotelPhoneNumber VARCHAR2(15),
    HotelRating     NUMBER
);

CREATE TABLE GUEST (
    GuestID                 NUMBER PRIMARY KEY,
    GuestPhoneNumber        VARCHAR2(15) UNIQUE,
    GuestAccountHolderName  VARCHAR2(100) NOT NULL
);

CREATE TABLE DEPARTMENT_P (
    DeptID          NUMBER PRIMARY KEY,
    HotelID         NUMBER NOT NULL,
    DeptName        VARCHAR2(50) UNIQUE NOT NULL,
    DeptPhoneNumber VARCHAR2(15),
    CONSTRAINT fk_department_hotel FOREIGN KEY (HotelID) REFERENCES HOTEL(HotelID)
);

CREATE TABLE STAFF (
    StaffID         NUMBER PRIMARY KEY,
    StaffSalary     NUMBER(10,2) NOT NULL,
    StaffFName      VARCHAR2(50) NOT NULL,
    StaffLName      VARCHAR2(50) NOT NULL,
    StaffPhoneNumber VARCHAR2(15) UNIQUE,
    StaffEmail      VARCHAR2(100) UNIQUE,
    DeptID          NUMBER NOT NULL,
    CONSTRAINT fk_staff_dept FOREIGN KEY (DeptID) REFERENCES DEPARTMENT_P(DeptID)
);

CREATE TABLE ROOM (
    RoomID          NUMBER PRIMARY KEY,
    HotelID         NUMBER NOT NULL,
    GuestID         NUMBER,
    RoomOccupants   NUMBER,
    RoomType        VARCHAR2(50) NOT NULL,
    RoomPrice       NUMBER,
    RoomStatus      VARCHAR2(20),
    RoomNumber      NUMBER,
    RoomFloor       NUMBER,
    CONSTRAINT fk_room_hotel  FOREIGN KEY (HotelID) REFERENCES HOTEL(HotelID),
    CONSTRAINT fk_room_guest  FOREIGN KEY (GuestID) REFERENCES GUEST(GuestID)
);

CREATE TABLE AMENITY (
    AmenityID          NUMBER PRIMARY KEY,
    AmenityName        VARCHAR2(100) NOT NULL,
    AmenityType        VARCHAR2(50),
    AmenityLocation    VARCHAR2(100),
    AmenityDescription VARCHAR2(500),
    HotelID            NUMBER NOT NULL,
    CONSTRAINT fk_amenity_hotel FOREIGN KEY (HotelID) REFERENCES HOTEL(HotelID)
);

CREATE TABLE EVENT (
    EventID          NUMBER PRIMARY KEY,
    EventDate        DATE NOT NULL,
    EventLocation    VARCHAR2(100),
    EventDescription VARCHAR2(500),
    HotelID          NUMBER NOT NULL,
    CONSTRAINT fk_event_hotel FOREIGN KEY (HotelID) REFERENCES HOTEL(HotelID)
);

CREATE TABLE RESTAURANT (
    RestID           NUMBER PRIMARY KEY,
    RestName         VARCHAR2(100) NOT NULL,
    RestPhoneNumber  VARCHAR2(20)  NOT NULL,
    HotelID          NUMBER NOT NULL,
    CONSTRAINT fk_rest_hotel FOREIGN KEY (HotelID) REFERENCES HOTEL(HotelID)
);

CREATE TABLE RESERVATION (
    ReservationID   NUMBER PRIMARY KEY,
    NoOfPeople      NUMBER NOT NULL,
    ResDate         DATE NOT NULL,
    RestID          NUMBER NOT NULL,
    GuestID         NUMBER NOT NULL,
    CONSTRAINT fk_res_rest  FOREIGN KEY (RestID)  REFERENCES RESTAURANT(RestID),
    CONSTRAINT fk_res_guest FOREIGN KEY (GuestID) REFERENCES GUEST(GuestID)
);

CREATE TABLE BILL (
    BillID        NUMBER PRIMARY KEY,
    ServiceCharge NUMBER,
    TaxAmount     NUMBER NOT NULL,
    StartDate     DATE NOT NULL,
    NightlyRate   NUMBER NOT NULL,
    EndDate       DATE NOT NULL,
    GuestID       NUMBER NOT NULL,
    CONSTRAINT fk_bill_guest FOREIGN KEY (GuestID) REFERENCES GUEST(GuestID)
);

CREATE SEQUENCE seq_hotel_id    START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_dept_id     START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_staff_id    START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_guest_id    START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_room_id     START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_amenity_id  START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_event_id    START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_rest_id     START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_res_id      START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_bill_id     START WITH 1 INCREMENT BY 1;

-- Search staff by last name
CREATE INDEX idx_staff_lname ON STAFF(StaffLName);

-- Search staff by department
CREATE INDEX idx_staff_dept  ON STAFF(DeptID);

-- Search guests by name
CREATE INDEX idx_guest_name  ON GUEST(GuestAccountHolderName);

-- Search rooms by status (e.g. find all available rooms)
CREATE INDEX idx_room_status ON ROOM(RoomStatus);

-- Search bills by date range
CREATE INDEX idx_bill_start  ON BILL(StartDate);

-- HOTEL
INSERT INTO HOTEL VALUES (seq_hotel_id.NEXTVAL, 'Polynesian Village', '1600 Seven Seas Dr, Lake Buena Vista, FL', '407-934-7639', 4.7);
INSERT INTO HOTEL VALUES (seq_hotel_id.NEXTVAL, 'Animal Kingdom Lodge', '2901 Osceola Pkwy, Lake Buena Vista, FL',  '407-934-7639', 4.8);

-- GUEST
INSERT INTO GUEST VALUES (seq_guest_id.NEXTVAL, '267-902-5682', 'Alice Johnson');
INSERT INTO GUEST VALUES (seq_guest_id.NEXTVAL, '215-851-4213', 'Bob Williams');
INSERT INTO GUEST VALUES (seq_guest_id.NEXTVAL, '502-476-1026', 'Carol Davis');

-- DEPARTMENT_P
INSERT INTO DEPARTMENT_P VALUES (seq_dept_id.NEXTVAL, 1, 'Housekeeping', '407-555-0101');
INSERT INTO DEPARTMENT_P VALUES (seq_dept_id.NEXTVAL, 1, 'Front Desk', '407-555-0102');
INSERT INTO DEPARTMENT_P VALUES (seq_dept_id.NEXTVAL, 2, 'Food And Beverage', '407-555-0201');

-- STAFF
INSERT INTO STAFF VALUES (seq_staff_id.NEXTVAL, 55000, 'John', 'Doe',   '212-555-0111', 'john.doe@hotel.com',   1);
INSERT INTO STAFF VALUES (seq_staff_id.NEXTVAL, 62000, 'Jane', 'Smith', '212-555-0112', 'jane.smith@hotel.com', 2);
INSERT INTO STAFF VALUES (seq_staff_id.NEXTVAL, 48000, 'Carlos', 'Rivera', '305-555-0211', 'c.rivera@hotel.com', 3);

-- ROOM
INSERT INTO ROOM VALUES (seq_room_id.NEXTVAL, 1, 1, 2, 'Double',  150.00, 'Occupied',  101, 1);
INSERT INTO ROOM VALUES (seq_room_id.NEXTVAL, 1, NULL, 0, 'Single', 99.00, 'Available', 102, 1);
INSERT INTO ROOM VALUES (seq_room_id.NEXTVAL, 2, 2, 3, 'Suite',   300.00, 'Occupied',  201, 2);

-- AMENITY
INSERT INTO AMENITY VALUES (seq_amenity_id.NEXTVAL, 'Swimming Pool', 'Recreation', 'Floor 1 - Outdoor', 'Outdoor pool open 6am-10pm',         1);
INSERT INTO AMENITY VALUES (seq_amenity_id.NEXTVAL, 'Gym',           'Recreation', 'Floor 2',           '24-hour gym with modern equipment',  1);
INSERT INTO AMENITY VALUES (seq_amenity_id.NEXTVAL, 'Free Wi-Fi',    'Technology', 'Entire Building',   'Complimentary high-speed internet',  2);

-- EVENT
INSERT INTO EVENT VALUES (seq_event_id.NEXTVAL, TO_DATE('2026-05-10','YYYY-MM-DD'), 'Seven Seas Lagoon Beach',    'Electrical Water Pageant', 1);
INSERT INTO EVENT VALUES (seq_event_id.NEXTVAL, TO_DATE('2026-05-15','YYYY-MM-DD'), 'Kidani Village', 'Starlight Safari', 1);

-- RESTAURANT
INSERT INTO RESTAURANT VALUES (seq_rest_id.NEXTVAL, 'Ohana', '407-939-5277', 1);
INSERT INTO RESTAURANT VALUES (seq_rest_id.NEXTVAL, 'Boma',  '407-939-5277', 2);

-- RESERVATION
INSERT INTO RESERVATION VALUES (seq_res_id.NEXTVAL, 4, TO_DATE('2026-04-15','YYYY-MM-DD'), 1, 1);
INSERT INTO RESERVATION VALUES (seq_res_id.NEXTVAL, 2, TO_DATE('2026-04-17','YYYY-MM-DD'), 2, 2);

-- BILL
INSERT INTO BILL VALUES (seq_bill_id.NEXTVAL, 50.00, 5.00, TO_DATE('2026-04-14','YYYY-MM-DD'), 200.00, TO_DATE('2026-04-16','YYYY-MM-DD'), 1);
INSERT INTO BILL VALUES (seq_bill_id.NEXTVAL, NULL,  3.00, TO_DATE('2026-04-15','YYYY-MM-DD'), 150.00, TO_DATE('2026-04-18','YYYY-MM-DD'), 2);

-- Commit to make data insertion permanent
COMMIT;

-- Example queries 
SELECT g.GuestAccountHolderName AS GuestName, (b.EndDate - b.StartDate)AS NightsStayed, b.NightlyRate, NVL(b.ServiceCharge, 0)AS ServiceCharge, b.TaxAmount, (b.NightlyRate * (b.EndDate - b.StartDate)) + NVL(b.ServiceCharge, 0) + b.TaxAmount AS TotalBillAmount
FROM BILL b
JOIN GUEST g ON b.GuestID = g.GuestID
ORDER BY TotalBillAmount DESC;

SELECT h.HotelName, r.RestName, COUNT(res.ReservationID) AS TotalReservations, SUM(res.NoOfPeople) AS TotalGuestsExpected
FROM RESERVATION res
JOIN RESTAURANT r ON res.RestID = r.RestID
JOIN HOTEL h ON r.HotelID = h.HotelID
GROUP BY h.HotelName, r.RestName
ORDER BY TotalReservations DESC;