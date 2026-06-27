-- CreateTable
CREATE TABLE "Student" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "avatar" TEXT,
    "instructorId" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Student_instructorId_fkey" FOREIGN KEY ("instructorId") REFERENCES "Instructor" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Instructor" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "logo" TEXT,
    "organization" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "url" TEXT,
    "description" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "Admin" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "Course" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "instructorId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "price" INTEGER NOT NULL,
    "thumbnailUrl" TEXT NOT NULL,
    "level" TEXT,
    "type" TEXT,
    "startDate" DATETIME,
    "endDate" DATETIME,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Course_instructorId_fkey" FOREIGN KEY ("instructorId") REFERENCES "Instructor" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "CourseFolder" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "courseId" TEXT NOT NULL,
    CONSTRAINT "CourseFolder_courseId_fkey" FOREIGN KEY ("courseId") REFERENCES "Course" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "CourseContent" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "courseFolderId" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "CourseContent_courseFolderId_fkey" FOREIGN KEY ("courseFolderId") REFERENCES "CourseFolder" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Enrollment" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "studentId" TEXT NOT NULL,
    "courseId" TEXT NOT NULL,
    "enrolledAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "Enrollment_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "Student" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Enrollment_courseId_fkey" FOREIGN KEY ("courseId") REFERENCES "Course" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "Student_email_instructorId_key" ON "Student"("email", "instructorId");

-- CreateIndex
CREATE UNIQUE INDEX "Instructor_email_key" ON "Instructor"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Instructor_organization_key" ON "Instructor"("organization");

-- CreateIndex
CREATE UNIQUE INDEX "Instructor_slug_key" ON "Instructor"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Instructor_url_key" ON "Instructor"("url");

-- CreateIndex
CREATE UNIQUE INDEX "Admin_email_key" ON "Admin"("email");

-- CreateIndex
CREATE UNIQUE INDEX "CourseFolder_courseId_name_key" ON "CourseFolder"("courseId", "name");

-- CreateIndex
CREATE UNIQUE INDEX "Enrollment_studentId_courseId_key" ON "Enrollment"("studentId", "courseId");
