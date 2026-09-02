# راهنمای منابع و ارجاع‌دهی

قالب از دو روش مستقل پشتیبانی می‌کند. در هر پروژه فقط یکی از دو روش فعال است، اما دستور ارجاع داخل متن در هر دو یکسان باقی می‌ماند.

## حالت اول: فایل Bib و Biber

مقدار ابتدای فایل اصلی:

```tex
\providecommand{\TMUBibliographyMode}{bib}
```

منابع در `Conductors/References.bib` قرار می‌گیرند. نمونه منبع فارسی:

```bibtex
@book{fa-key,
  author    = {{نام نویسنده}},
  title     = {عنوان کتاب},
  publisher = {نام ناشر},
  year      = {1405},
  keywords  = {persian}
}
```

نمونه منبع انگلیسی:

```bibtex
@article{en-key,
  author   = {Family, Given},
  title    = {Article Title},
  journal  = {Journal Title},
  volume   = {1},
  number   = {2},
  pages    = {1--20},
  year     = {2026},
  keywords = {english}
}
```

کلید `keywords = {persian}` منبع را در بخش راست‌به‌چپ کتاب‌نامه قرار می‌دهد. سایر منابع در بخش انگلیسی و چپ‌به‌راست چاپ می‌شوند.

ارجاع در متن:

```tex
نتیجه مورد استفاده در \cite{fa-key} آمده است.
```

## حالت دوم: کتاب‌نامه دستی

مقدار ابتدای فایل اصلی:

```tex
\providecommand{\TMUBibliographyMode}{manual}
```

منابع در `Conductors/References.tex` و با `\bibitem` تعریف می‌شوند:

```tex
\begin{thebibliography}{99}

\bibitem{fa-key}
نام نویسنده، \emph{عنوان کتاب}، نام ناشر، ۱۴۰۵.

\begin{latin}
\bibitem{en-key}
Given Family, \emph{Book Title}, Publisher, 2026.
\end{latin}

\end{thebibliography}
```

ارجاع در متن همچنان با `\cite{fa-key}` نوشته می‌شود.

## قواعد مشترک

- هر کلید باید یکتا، کوتاه و پایدار باشد.
- کلید تعریف‌شده در منبع باید دقیقاً با کلید داخل `\cite{...}` یکسان باشد.
- فایل `References.bib` باید با UTF-8 ذخیره شود.
- در حالت `bib` حذف فایل‌های موقت و ساخت مجدد، مشکلات ناشی از تغییر کلیدها را رفع می‌کند.
- تغییر هم‌زمان `References.bib` و `References.tex` لازم نیست؛ فقط فایل مربوط به حالت فعال در خروجی استفاده می‌شود.
