CREATE TABLE [IR].[Lock] (
    [LockID]      INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [LockTypeID]  NVARCHAR (15)  NOT NULL,
    [Key]         NVARCHAR (15)  NOT NULL,
    [BeginDate]   DATETIME       NOT NULL,
    [EndDate]     DATETIME       NULL,
    [UserName]    NVARCHAR (50)  NOT NULL,
    [Description] NVARCHAR (200) NULL,
    [Comment]     NVARCHAR (800) NULL,
    [SoftDeleted] BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]  ROWVERSION     NOT NULL,
    CONSTRAINT [PK_Lock] PRIMARY KEY CLUSTERED ([LockID] ASC),
    CONSTRAINT [FK_Lock_LockType] FOREIGN KEY ([LockTypeID]) REFERENCES [IR].[LockType] ([LockTypeID]),
    CONSTRAINT [UK_Lock] UNIQUE NONCLUSTERED ([LockTypeID] ASC, [Key] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_Lock]
    ON [IR].[Lock]([LockTypeID] ASC, [Key] ASC)
    ON [Indexes];

