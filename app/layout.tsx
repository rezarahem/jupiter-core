import type { Metadata } from 'next';
import localFont from 'next/font/local';
import './globals.css';
import { ThemeProvider } from '@/providers/theme-provider';

const vazir = localFont({
  src: '../fonts/vazirmatn-vf.ttf',
  variable: '--font-vazir',
  weight: '100 900',
});

export const metadata: Metadata = {
  title: `${process.env.NEXt_PUBLIC_APP}`,
  description: `${process.env.NEXt_PUBLIC_APP} application`,
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html dir='rtl' lang='fa' suppressHydrationWarning>
      <body className={vazir.className}>
      <ThemeProvider
          attribute='class'
          defaultTheme='system'
          enableSystem
          disableTransitionOnChange>
          {children}
        </ThemeProvider>
      </body>
    </html>
  );
}
