import { Preview } from '@react-email/components';
import { Tailwind } from '@react-email/tailwind';

const app = process.env.NEXT_PUBLIC_APP as string;

const OtpEmail = ({ otp }: { otp: string }) => {
  return (
    <Tailwind>
      <Preview>کد تایید یکبار مصرف | {app}</Preview>
      <div className='bg-gray-100 py-10'>
        <div className='mx-auto max-w-md rounded-md bg-white p-6 shadow-md'>
          <h1 className='text-2xl font-bold text-gray-800'>
            کد تایید یکبار مصرف | {app}
          </h1>
          <p className='mt-4 text-gray-600'>کد تایید جهت ورود</p>
          <div className='mt-6 rounded-md bg-gray-100 px-4 py-2 text-center font-mono text-xl font-bold text-black'>
            {otp}
          </div>
          <p className='mt-4 text-sm text-gray-500'>
            اگر شما درخواست این کد را نداده‌اید، می‌توانید این ایمیل را نادیده
            بگیرید.
          </p>
        </div>
      </div>
    </Tailwind>
  );
};

export default OtpEmail;
