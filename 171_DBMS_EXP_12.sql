SET SERVEROUTPUT ON
SET LINESIZE 150
SET PAGESIZE 100

-- ========================================================
--          LIBRARY MANAGEMENT SYSTEM
-- ========================================================



------------------------------------------------------------
-- 1. CREATE TABLE: CATEGORIES
------------------------------------------------------------

CREATE TABLE categories (
    category_id NUMBER PRIMARY KEY,
    category_name VARCHAR2(50) NOT NULL
);

-- OUTPUT
-- Table CATEGORIES created.


------------------------------------------------------------
-- 2. CREATE TABLE: AUTHORS
------------------------------------------------------------

CREATE TABLE authors (
    author_id NUMBER PRIMARY KEY,
    author_name VARCHAR2(100) NOT NULL
);

-- OUTPUT
-- Table AUTHORS created.


------------------------------------------------------------
-- 3. CREATE TABLE: BOOKS
------------------------------------------------------------

CREATE TABLE books (
    book_id NUMBER PRIMARY KEY,
    title VARCHAR2(150) NOT NULL,
    author_id NUMBER REFERENCES authors(author_id),
    category_id NUMBER REFERENCES categories(category_id),
    publication_year NUMBER(4),
    total_copies NUMBER DEFAULT 1,
    available_copies NUMBER DEFAULT 1
);

-- OUTPUT
-- Table BOOKS created.


------------------------------------------------------------
-- 4. CREATE TABLE: MEMBERS
------------------------------------------------------------

CREATE TABLE members (
    member_id NUMBER PRIMARY KEY,
    member_name VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE,
    phone VARCHAR2(15),
    join_date DATE DEFAULT SYSDATE
);

-- OUTPUT
-- Table MEMBERS created.


------------------------------------------------------------
-- 5. CREATE TABLE: LOANS
------------------------------------------------------------

CREATE TABLE loans (
    loan_id NUMBER PRIMARY KEY,
    book_id NUMBER REFERENCES books(book_id),
    member_id NUMBER REFERENCES members(member_id),
    issue_date DATE DEFAULT SYSDATE,
    due_date DATE,
    return_date DATE
);

-- OUTPUT
-- Table LOANS created.


------------------------------------------------------------
-- 6. CREATE SEQUENCES
------------------------------------------------------------

CREATE SEQUENCE category_seq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE author_seq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE book_seq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE member_seq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE loan_seq
START WITH 1
INCREMENT BY 1;

-- OUTPUT
-- Sequence CATEGORY_SEQ created.
-- Sequence AUTHOR_SEQ created.
-- Sequence BOOK_SEQ created.
-- Sequence MEMBER_SEQ created.
-- Sequence LOAN_SEQ created.


------------------------------------------------------------
-- 7. INSERT CATEGORIES
------------------------------------------------------------

INSERT INTO categories
VALUES (category_seq.NEXTVAL, 'Programming');

INSERT INTO categories
VALUES (category_seq.NEXTVAL, 'Database');

INSERT INTO categories
VALUES (category_seq.NEXTVAL, 'Fiction');

INSERT INTO categories
VALUES (category_seq.NEXTVAL, 'Science');

INSERT INTO categories
VALUES (category_seq.NEXTVAL, 'History');

-- OUTPUT
-- 1 row inserted.
-- 1 row inserted.
-- 1 row inserted.
-- 1 row inserted.
-- 1 row inserted.


------------------------------------------------------------
-- 8. INSERT AUTHORS
------------------------------------------------------------

INSERT INTO authors
VALUES (author_seq.NEXTVAL, 'Robert C. Martin');

INSERT INTO authors
VALUES (author_seq.NEXTVAL, 'Ramez Elmasri');

INSERT INTO authors
VALUES (author_seq.NEXTVAL, 'George Orwell');

INSERT INTO authors
VALUES (author_seq.NEXTVAL, 'Stephen Hawking');

INSERT INTO authors
VALUES (author_seq.NEXTVAL, 'Yuval Noah Harari');

-- OUTPUT
-- 1 row inserted.
-- 1 row inserted.
-- 1 row inserted.
-- 1 row inserted.
-- 1 row inserted.


------------------------------------------------------------
-- 9. INSERT BOOKS
------------------------------------------------------------

INSERT INTO books
VALUES (
    book_seq.NEXTVAL,
    'Clean Code',
    1,
    1,
    2008,
    5,
    4
);

INSERT INTO books
VALUES (
    book_seq.NEXTVAL,
    'Database Systems',
    2,
    2,
    2016,
    4,
    3
);

INSERT INTO books
VALUES (
    book_seq.NEXTVAL,
    '1984',
    3,
    3,
    1949,
    6,
    5
);

INSERT INTO books
VALUES (
    book_seq.NEXTVAL,
    'A Brief History of Time',
    4,
    4,
    1988,
    3,
    2
);

INSERT INTO books
VALUES (
    book_seq.NEXTVAL,
    'Sapiens',
    5,
    5,
    2011,
    5,
    5
);

INSERT INTO books
VALUES (
    book_seq.NEXTVAL,
    'The Art of Computer Programming',
    1,
    1,
    2000,
    2,
    2
);

-- OUTPUT
-- 1 row inserted.
-- 1 row inserted.
-- 1 row inserted.
-- 1 row inserted.
-- 1 row inserted.
-- 1 row inserted.


------------------------------------------------------------
-- 10. INSERT MEMBERS
------------------------------------------------------------

INSERT INTO members
VALUES (
    member_seq.NEXTVAL,
    'Arun Kumar',
    'arun@gmail.com',
    '9876543210',
    DATE '2025-01-10'
);

INSERT INTO members
VALUES (
    member_seq.NEXTVAL,
    'Priya Sharma',
    'priya@gmail.com',
    '9876543211',
    DATE '2025-02-15'
);

INSERT INTO members
VALUES (
    member_seq.NEXTVAL,
    'Rahul Das',
    'rahul@gmail.com',
    '9876543212',
    DATE '2025-03-20'
);

INSERT INTO members
VALUES (
    member_seq.NEXTVAL,
    'Sneha Rao',
    'sneha@gmail.com',
    '9876543213',
    DATE '2025-04-05'
);

-- OUTPUT
-- 1 row inserted.
-- 1 row inserted.
-- 1 row inserted.
-- 1 row inserted.


------------------------------------------------------------
-- 11. INSERT LOANS
------------------------------------------------------------

INSERT INTO loans
VALUES (
    loan_seq.NEXTVAL,
    1,
    1,
    DATE '2025-06-01',
    DATE '2025-06-15',
    DATE '2025-06-12'
);

INSERT INTO loans
VALUES (
    loan_seq.NEXTVAL,
    2,
    2,
    DATE '2025-06-05',
    DATE '2025-06-19',
    NULL
);

INSERT INTO loans
VALUES (
    loan_seq.NEXTVAL,
    3,
    3,
    DATE '2025-06-10',
    DATE '2025-06-24',
    DATE '2025-06-20'
);

INSERT INTO loans
VALUES (
    loan_seq.NEXTVAL,
    4,
    4,
    DATE '2025-06-12',
    DATE '2025-06-26',
    NULL
);

COMMIT;

-- OUTPUT
-- 1 row inserted.
-- 1 row inserted.
-- 1 row inserted.
-- 1 row inserted.
-- Commit complete.


------------------------------------------------------------
-- 12. DISPLAY ALL BOOKS
------------------------------------------------------------

SELECT
    book_id,
    title,
    publication_year,
    total_copies,
    available_copies
FROM books
ORDER BY book_id;

-- OUTPUT
--
--    BOOK_ID TITLE                              PUBLICATION_YEAR TOTAL_COPIES AVAILABLE_COPIES
-- ---------- --------------------------------- ---------------- ------------ ----------------
--          1 Clean Code                        2008                        5                4
--          2 Database Systems                  2016                        4                3
--          3 1984                              1949                        6                5
--          4 A Brief History of Time           1988                        3                2
--          5 Sapiens                           2011                        5                5
--          6 The Art of Computer Programming   2000                        2                2


------------------------------------------------------------
-- 13. DISPLAY BOOKS WITH AUTHOR AND CATEGORY
------------------------------------------------------------

SELECT
    b.book_id,
    b.title,
    a.author_name,
    c.category_name,
    b.publication_year,
    b.available_copies
FROM books b
JOIN authors a
ON b.author_id = a.author_id
JOIN categories c
ON b.category_id = c.category_id
ORDER BY b.book_id;

-- OUTPUT
--
-- BOOK_ID  TITLE
-- -------  ---------------------------------
-- AUTHOR_NAME          CATEGORY_NAME
-- -------------------  -------------
-- PUBLICATION_YEAR     AVAILABLE_COPIES
-- ----------------     ----------------
--
-- 1        Clean Code
-- Robert C. Martin     Programming
-- 2008                 4
--
-- 2        Database Systems
-- Ramez Elmasri        Database
-- 2016                 3
--
-- 3        1984
-- George Orwell        Fiction
-- 1949                 5
--
-- 4        A Brief History of Time
-- Stephen Hawking      Science
-- 1988                 2
--
-- 5        Sapiens
-- Yuval Noah Harari    History
-- 2011                 5
--
-- 6        The Art of Computer Programming
-- Robert C. Martin     Programming
-- 2000                 2


------------------------------------------------------------
-- 14. DISPLAY MEMBERS
------------------------------------------------------------

SELECT
    member_id,
    member_name,
    email,
    phone,
    join_date
FROM members
ORDER BY member_id;

-- OUTPUT
--
-- MEMBER_ID MEMBER_NAME    EMAIL             PHONE       JOIN_DATE
-- --------- -------------  ----------------  ----------  ---------
-- 1         Arun Kumar     arun@gmail.com    9876543210  10-JAN-25
-- 2         Priya Sharma   priya@gmail.com   9876543211  15-FEB-25
-- 3         Rahul Das      rahul@gmail.com   9876543212  20-MAR-25
-- 4         Sneha Rao      sneha@gmail.com   9876543213  05-APR-25


------------------------------------------------------------
-- 15. DISPLAY AVAILABLE BOOKS
------------------------------------------------------------

SELECT
    book_id,
    title,
    available_copies
FROM books
WHERE available_copies > 0
ORDER BY book_id;

-- OUTPUT
--
-- BOOK_ID  TITLE                              AVAILABLE_COPIES
-- -------  --------------------------------  ----------------
-- 1        Clean Code                        4
-- 2        Database Systems                  3
-- 3        1984                              5
-- 4        A Brief History of Time           2
-- 5        Sapiens                           5
-- 6        The Art of Computer Programming  2


------------------------------------------------------------
-- 16. SEARCH BOOK
------------------------------------------------------------

SELECT
    book_id,
    title
FROM books
WHERE LOWER(title) LIKE '%computer%';

-- OUTPUT
--
-- BOOK_ID  TITLE
-- -------  ---------------------------------
-- 6        The Art of Computer Programming


------------------------------------------------------------
-- 17. BOOKS PUBLISHED AFTER 2000
------------------------------------------------------------

SELECT
    title,
    publication_year
FROM books
WHERE publication_year > 2000
ORDER BY publication_year;

-- OUTPUT
--
-- TITLE                    PUBLICATION_YEAR
-- -----------------------  ----------------
-- Clean Code               2008
-- Sapiens                  2011
-- Database Systems         2016


------------------------------------------------------------
-- 18. TOTAL BOOK TITLES
------------------------------------------------------------

SELECT COUNT(*) AS total_book_titles
FROM books;

-- OUTPUT
--
-- TOTAL_BOOK_TITLES
-- -----------------
-- 6


------------------------------------------------------------
-- 19. TOTAL BOOK COPIES
------------------------------------------------------------

SELECT SUM(total_copies) AS total_copies
FROM books;

-- OUTPUT
--
-- TOTAL_COPIES
-- ------------
-- 25


------------------------------------------------------------
-- 20. AVAILABLE COPIES
------------------------------------------------------------

SELECT SUM(available_copies) AS available_copies
FROM books;

-- OUTPUT
--
-- AVAILABLE_COPIES
-- ----------------
-- 21


------------------------------------------------------------
-- 21. TOTAL MEMBERS
------------------------------------------------------------

SELECT COUNT(*) AS total_members
FROM members;

-- OUTPUT
--
-- TOTAL_MEMBERS
-- -------------
-- 4


------------------------------------------------------------
-- 22. CATEGORY-WISE BOOK COUNT
------------------------------------------------------------

SELECT
    c.category_name,
    COUNT(b.book_id) AS number_of_books
FROM categories c
LEFT JOIN books b
ON c.category_id = b.category_id
GROUP BY c.category_name
ORDER BY c.category_name;

-- OUTPUT
--
-- CATEGORY_NAME    NUMBER_OF_BOOKS
-- ---------------  ---------------
-- Database         1
-- Fiction          1
-- History          1
-- Programming      2
-- Science          1


------------------------------------------------------------
-- 23. CURRENTLY BORROWED BOOKS
------------------------------------------------------------

SELECT
    l.loan_id,
    m.member_name,
    b.title,
    l.issue_date,
    l.due_date
FROM loans l
JOIN members m
ON l.member_id = m.member_id
JOIN books b
ON l.book_id = b.book_id
WHERE l.return_date IS NULL
ORDER BY l.loan_id;

-- OUTPUT
--
-- LOAN_ID  MEMBER_NAME    TITLE                    ISSUE_DATE  DUE_DATE
-- -------  -------------  -----------------------  ----------  ---------
-- 2        Priya Sharma   Database Systems         05-JUN-25   19-JUN-25
-- 4        Sneha Rao      A Brief History of Time  12-JUN-25   26-JUN-25


------------------------------------------------------------
-- 24. COMPLETE LOAN HISTORY
------------------------------------------------------------

SELECT
    l.loan_id,
    m.member_name,
    b.title,
    l.issue_date,
    l.due_date,
    l.return_date
FROM loans l
JOIN members m
ON l.member_id = m.member_id
JOIN books b
ON l.book_id = b.book_id
ORDER BY l.loan_id;

-- OUTPUT
--
-- LOAN_ID  MEMBER_NAME    TITLE                    ISSUE_DATE  DUE_DATE    RETURN_DATE
-- -------  -------------  -----------------------  ----------  ----------  -----------
-- 1        Arun Kumar     Clean Code               01-JUN-25   15-JUN-25   12-JUN-25
-- 2        Priya Sharma   Database Systems         05-JUN-25   19-JUN-25
-- 3        Rahul Das      1984                     10-JUN-25   24-JUN-25   20-JUN-25
-- 4        Sneha Rao      A Brief History of Time  12-JUN-25   26-JUN-25


------------------------------------------------------------
-- 25. MEMBER-WISE BORROW COUNT
------------------------------------------------------------

SELECT
    m.member_name,
    COUNT(l.loan_id) AS books_borrowed
FROM members m
LEFT JOIN loans l
ON m.member_id = l.member_id
GROUP BY m.member_id, m.member_name
ORDER BY m.member_id;

-- OUTPUT
--
-- MEMBER_NAME    BOOKS_BORROWED
-- -------------  --------------
-- Arun Kumar     1
-- Priya Sharma   1
-- Rahul Das      1
-- Sneha Rao      1


------------------------------------------------------------
-- 26. BOOKS NEVER BORROWED
------------------------------------------------------------

SELECT
    b.book_id,
    b.title
FROM books b
LEFT JOIN loans l
ON b.book_id = l.book_id
WHERE l.loan_id IS NULL
ORDER BY b.book_id;

-- OUTPUT
--
-- BOOK_ID  TITLE
-- -------  ---------------------------------
-- 5        Sapiens
-- 6        The Art of Computer Programming


------------------------------------------------------------
-- 27. OVERDUE BOOKS
------------------------------------------------------------

SELECT
    l.loan_id,
    m.member_name,
    b.title,
    l.due_date
FROM loans l
JOIN members m
ON l.member_id = m.member_id
JOIN books b
ON l.book_id = b.book_id
WHERE l.return_date IS NULL
AND l.due_date < TRUNC(SYSDATE)
ORDER BY l.loan_id;

-- OUTPUT WITH THE DATE USED IN YOUR ORIGINAL RUN
--
-- LOAN_ID  MEMBER_NAME    TITLE                    DUE_DATE
-- -------  -------------  -----------------------  ---------
-- 2        Priya Sharma   Database Systems         19-JUN-25
-- 4        Sneha Rao      A Brief History of Time  26-JUN-25


------------------------------------------------------------
-- 28. FINE CALCULATION
-- Rs.5 PER DAY
------------------------------------------------------------

SELECT
    l.loan_id,
    m.member_name,
    b.title,
    l.due_date,
    CASE
        WHEN NVL(l.return_date, TRUNC(SYSDATE)) > l.due_date
        THEN
            (NVL(l.return_date, TRUNC(SYSDATE))
             - l.due_date) * 5
        ELSE 0
    END AS fine_amount
FROM loans l
JOIN members m
ON l.member_id = m.member_id
JOIN books b
ON l.book_id = b.book_id
ORDER BY l.loan_id;

-- OUTPUT FROM YOUR ORIGINAL RUN
--
-- LOAN_ID  MEMBER_NAME    TITLE                    FINE_AMOUNT
-- -------  -------------  -----------------------  -----------
-- 1        Arun Kumar     Clean Code                        0
-- 2        Priya Sharma   Database Systems               2315
-- 3        Rahul Das      1984                              0
-- 4        Sneha Rao      A Brief History of Time        2280
--
-- NOTE:
-- The fine for active loans depends on SYSDATE.
-- Therefore these two values change when the script
-- is executed on a different date.


------------------------------------------------------------
-- 29. PL/SQL SUMMARY
------------------------------------------------------------

DECLARE
    v_books NUMBER;
    v_copies NUMBER;
    v_available NUMBER;
    v_members NUMBER;
    v_loans NUMBER;
BEGIN

    SELECT COUNT(*)
    INTO v_books
    FROM books;

    SELECT SUM(total_copies)
    INTO v_copies
    FROM books;

    SELECT SUM(available_copies)
    INTO v_available
    FROM books;

    SELECT COUNT(*)
    INTO v_members
    FROM members;

    SELECT COUNT(*)
    INTO v_loans
    FROM loans
    WHERE return_date IS NULL;

    DBMS_OUTPUT.PUT_LINE('======================================');
    DBMS_OUTPUT.PUT_LINE('       LIBRARY MANAGEMENT SYSTEM');
    DBMS_OUTPUT.PUT_LINE('======================================');
    DBMS_OUTPUT.PUT_LINE('Total Book Titles : ' || v_books);
    DBMS_OUTPUT.PUT_LINE('Total Copies      : ' || v_copies);
    DBMS_OUTPUT.PUT_LINE('Available Copies  : ' || v_available);
    DBMS_OUTPUT.PUT_LINE('Total Members     : ' || v_members);
    DBMS_OUTPUT.PUT_LINE('Active Loans      : ' || v_loans);
    DBMS_OUTPUT.PUT_LINE('======================================');

END;
/

-- OUTPUT
--
-- ======================================
--        LIBRARY MANAGEMENT SYSTEM
-- ======================================
-- Total Book Titles : 6
-- Total Copies      : 25
-- Available Copies  : 21
-- Total Members     : 4
-- Active Loans      : 2
-- ======================================


------------------------------------------------------------
-- 30. PL/SQL CURSOR
------------------------------------------------------------

DECLARE

    CURSOR book_cursor IS
        SELECT
            b.title,
            a.author_name
        FROM books b
        JOIN authors a
        ON b.author_id = a.author_id
        ORDER BY b.book_id;

BEGIN

    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('========== BOOK LIST ==========');

    FOR r IN book_cursor
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            r.title || ' - ' || r.author_name
        );
    END LOOP;

END;
/

-- OUTPUT
--
-- ========== BOOK LIST ==========
-- Clean Code - Robert C. Martin
-- Database Systems - Ramez Elmasri
-- 1984 - George Orwell
-- A Brief History of Time - Stephen Hawking
-- Sapiens - Yuval Noah Harari
-- The Art of Computer Programming - Robert C. Martin


------------------------------------------------------------
-- 31. CREATE BOOK VIEW
------------------------------------------------------------

CREATE OR REPLACE VIEW book_details AS
SELECT
    b.book_id,
    b.title,
    a.author_name,
    c.category_name,
    b.publication_year,
    b.total_copies,
    b.available_copies
FROM books b
JOIN authors a
ON b.author_id = a.author_id
JOIN categories c
ON b.category_id = c.category_id;

-- OUTPUT
-- View BOOK_DETAILS created.


------------------------------------------------------------
-- 32. DISPLAY BOOK VIEW
------------------------------------------------------------

SELECT *
FROM book_details
ORDER BY book_id;

-- OUTPUT
--
-- BOOK_ID  TITLE                              AUTHOR_NAME
-- -------  --------------------------------  -------------------
-- 1        Clean Code                        Robert C. Martin
-- 2        Database Systems                  Ramez Elmasri
-- 3        1984                              George Orwell
-- 4        A Brief History of Time           Stephen Hawking
-- 5        Sapiens                           Yuval Noah Harari
-- 6        The Art of Computer Programming   Robert C. Martin


------------------------------------------------------------
-- 33. CREATE ACTIVE LOANS VIEW
------------------------------------------------------------

CREATE OR REPLACE VIEW active_loans AS
SELECT
    l.loan_id,
    m.member_name,
    b.title,
    l.issue_date,
    l.due_date
FROM loans l
JOIN members m
ON l.member_id = m.member_id
JOIN books b
ON l.book_id = b.book_id
WHERE l.return_date IS NULL;

-- OUTPUT
-- View ACTIVE_LOANS created.


------------------------------------------------------------
-- 34. DISPLAY ACTIVE LOANS
------------------------------------------------------------

SELECT *
FROM active_loans
ORDER BY loan_id;

-- OUTPUT
--
-- LOAN_ID  MEMBER_NAME    TITLE                    ISSUE_DATE  DUE_DATE
-- -------  -------------  -----------------------  ----------  ---------
-- 2        Priya Sharma   Database Systems         05-JUN-25   19-JUN-25
-- 4        Sneha Rao      A Brief History of Time  12-JUN-25   26-JUN-25


------------------------------------------------------------
-- 35. FINE FUNCTION
------------------------------------------------------------

CREATE OR REPLACE FUNCTION calculate_fine(
    p_loan_id NUMBER
)
RETURN NUMBER
IS
    v_due_date DATE;
    v_return_date DATE;
    v_fine NUMBER;
BEGIN

    SELECT
        due_date,
        return_date
    INTO
        v_due_date,
        v_return_date
    FROM loans
    WHERE loan_id = p_loan_id;

    IF NVL(v_return_date, TRUNC(SYSDATE)) > v_due_date THEN

        v_fine :=
            (NVL(v_return_date, TRUNC(SYSDATE))
            - v_due_date) * 5;

    ELSE

        v_fine := 0;

    END IF;

    RETURN v_fine;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END;
/

-- OUTPUT
-- Function CALCULATE_FINE compiled.


------------------------------------------------------------
-- 36. TEST FINE FUNCTION
------------------------------------------------------------

SELECT
    loan_id,
    calculate_fine(loan_id) AS fine
FROM loans
ORDER BY loan_id;

-- OUTPUT FROM YOUR ORIGINAL RUN
--
-- LOAN_ID  FINE
-- -------  ----
-- 1        0
-- 2        2315
-- 3        0
-- 4        2280


------------------------------------------------------------
-- 37. ISSUE BOOK PROCEDURE
------------------------------------------------------------

CREATE OR REPLACE PROCEDURE issue_book(
    p_book_id NUMBER,
    p_member_id NUMBER
)
IS
    v_available NUMBER;
BEGIN

    SELECT available_copies
    INTO v_available
    FROM books
    WHERE book_id = p_book_id;

    IF v_available > 0 THEN

        INSERT INTO loans
        (
            loan_id,
            book_id,
            member_id,
            issue_date,
            due_date
        )
        VALUES
        (
            loan_seq.NEXTVAL,
            p_book_id,
            p_member_id,
            TRUNC(SYSDATE),
            TRUNC(SYSDATE) + 14
        );

        UPDATE books
        SET available_copies = available_copies - 1
        WHERE book_id = p_book_id;

        COMMIT;

        DBMS_OUTPUT.PUT_LINE(
            'Book issued successfully.'
        );

    ELSE

        DBMS_OUTPUT.PUT_LINE(
            'Book is not available.'
        );

    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(
            'Book does not exist.'
        );
END;
/

-- OUTPUT
-- Procedure ISSUE_BOOK compiled.


------------------------------------------------------------
-- 38. TEST ISSUE BOOK
------------------------------------------------------------

BEGIN
    issue_book(5, 1);
END;
/

-- OUTPUT
-- Book issued successfully.


------------------------------------------------------------
-- 39. RETURN BOOK PROCEDURE
------------------------------------------------------------

CREATE OR REPLACE PROCEDURE return_book(
    p_loan_id NUMBER
)
IS
    v_book_id NUMBER;
    v_return_date DATE;
BEGIN

    SELECT
        book_id,
        return_date
    INTO
        v_book_id,
        v_return_date
    FROM loans
    WHERE loan_id = p_loan_id;

    IF v_return_date IS NULL THEN

        UPDATE loans
        SET return_date = TRUNC(SYSDATE)
        WHERE loan_id = p_loan_id;

        UPDATE books
        SET available_copies = available_copies + 1
        WHERE book_id = v_book_id;

        COMMIT;

        DBMS_OUTPUT.PUT_LINE(
            'Book returned successfully.'
        );

    ELSE

        DBMS_OUTPUT.PUT_LINE(
            'Book was already returned.'
        );

    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(
            'Loan record does not exist.'
        );
END;
/

-- OUTPUT
-- Procedure RETURN_BOOK compiled.


------------------------------------------------------------
-- 40. TEST RETURN BOOK
------------------------------------------------------------

BEGIN
    return_book(2);
END;
/

-- OUTPUT
-- Book returned successfully.


------------------------------------------------------------
-- 41. FINAL REPORT
------------------------------------------------------------

SELECT
    b.book_id,
    b.title,
    a.author_name,
    c.category_name,
    b.total_copies,
    b.available_copies
FROM books b
JOIN authors a
ON b.author_id = a.author_id
JOIN categories c
ON b.category_id = c.category_id
ORDER BY b.book_id;

-- OUTPUT
--
-- BOOK_ID  TITLE                              AUTHOR_NAME
-- -------  --------------------------------  -------------------
-- CATEGORY_NAME    TOTAL_COPIES  AVAILABLE_COPIES
-- ---------------  ------------  ----------------
--
-- 1        Clean Code                        Robert C. Martin
-- Programming       5             4
--
-- 2        Database Systems                  Ramez Elmasri
-- Database          4             4
--
-- 3        1984                              George Orwell
-- Fiction           6             5
--
-- 4        A Brief History of Time           Stephen Hawking
-- Science           3             2
--
-- 5        Sapiens                           Yuval Noah Harari
-- History           5             4
--
-- 6        The Art of Computer Programming   Robert C. Martin
-- Programming       2             2


------------------------------------------------------------
-- 42. FINAL PL/SQL MESSAGE
------------------------------------------------------------

BEGIN

    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('======================================');
    DBMS_OUTPUT.PUT_LINE(' LIBRARY PROJECT EXECUTED SUCCESSFULLY');
    DBMS_OUTPUT.PUT_LINE('======================================');

END;
/

-- OUTPUT
--
-- ======================================
--  LIBRARY PROJECT EXECUTED SUCCESSFULLY
-- ======================================


------------------------------------------------------------
-- END OF LIBRARY MANAGEMENT SYSTEM
------------------------------------------------------------

COMMIT;

-- OUTPUT
-- Commit complete.
