# note

# ファイル構成のメモ
    lib/
        models/
            memo group
                key
                title
                memos
                memos bloc

            memo
                key
                text
    view/
        pages/
            page memo groups
            page memos
                parent
                memo(
                    onChanged:parent.update(memo)
                    onDelete:parent.deleteMemo(memo)
                )
         widget/
            memo group
                target group
            memo
                target memo
                onChanged
                onDeleted

    bloc/
        memo groups bloc
        memos bloc
