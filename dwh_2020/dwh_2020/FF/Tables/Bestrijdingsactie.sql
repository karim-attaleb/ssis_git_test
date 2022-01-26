CREATE TABLE [FF].[Bestrijdingsactie] (
    [BestrijdingsactieID] NVARCHAR (15)  NOT NULL,
    [Description]         NVARCHAR (300) NOT NULL,
    [DependencySet]       NVARCHAR (300) NULL,
    [SortOrder]           INT            NULL,
    [Comment]             NVARCHAR (800) NULL,
    [SoftDeleted]         BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]          ROWVERSION     NOT NULL,
    CONSTRAINT [PK_Bestrijdingsactie] PRIMARY KEY CLUSTERED ([BestrijdingsactieID] ASC)
);

