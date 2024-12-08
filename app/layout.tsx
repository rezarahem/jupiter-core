import './globals.css';
import type { Metadata } from 'next';
import { ThemeProvider } from '@/providers/theme-provider';


export const metadata: Metadata = {
  title: `${process.env.NEXT_PUBLIC_APP}`,
  description: `${process.env.NEXT_PUBLIC_APP} application`,
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html suppressHydrationWarning>
      <body>
        <ThemeProvider
          attribute='class'
          defaultTheme='system'
          enableSystem
          disableTransitionOnChange
        >
          {children}
        </ThemeProvider>
      </body>
    </html>
  );
}
