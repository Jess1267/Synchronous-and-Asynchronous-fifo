# Synchronous-and-Asynchronous-fifo
## First In First Out
FIFO buffers are employed as temporary storage elements within systems where modules operate at varying clock frequencies or process data at different speeds. This asynchronous operation can lead to data loss if not properly managed. The FIFO acts as a buffer, accommodating data flow discrepancies and preventing data loss by temporarily storing data from the faster module until the slower module is ready to receive it. Sometimes its also used when data width are mismatched. 

Data is written in the order it is received (first in) and read in the same order (first out).

Components of FIFO : Read_enable(rd_en), Write_enable(wrt_en), read_pointer(rd_ptr), write_pointer(wrt_ptr), data_in, data_out

## Edge cases of FIFO
### Fifo Full
When the write module operates at a faster rate than the read module, the available memory locations within the FIFO buffer become fully occupied. Attempting to write further data into a full FIFO results in data overflow and subsequent data loss. This condition, known as FIFO full, occurs when the write pointer surpasses the allocated memory space.
### Fifo Empty
If the read module operates at a faster rate than the write module, the FIFO buffer eventually becomes depleted of data. Continued attempts to read from an empty FIFO will result in the retrieval of erroneous or invalid data. This condition, referred to as FIFO empty, arises when the read pointer exceeds the available data within the buffer.

## Synchronous FIFO
They works on same clock domain but the speed of writing and reading differs. Buffering between two subsystems with different data rates but the same clock.

### Synchronus FIFO Module
![image](https://github.com/user-attachments/assets/802cd16f-9de7-48d5-a382-29ed96f2c67a)

### Waveform for synchronus FIFO
![image](https://github.com/user-attachments/assets/5f89010a-4fd2-410e-8e7e-a3c3df5cbd11)

## Asynchronous FIFO
An asynchronous FIFO buffer is designed to operate between two clock domains with different clock frequencies. It allows seamless data transfer between two systems that are not synchronized. 

Gray code is used in asynchronous FIFOs because it minimizes errors when crossing clock domains by ensuring that only one bit changes at a time during pointer updates. This behavior is critical in asynchronous FIFOs, where pointers need to be transferred between different clock domains to calculate full and empty flags.

Synchronizers are needed in an asynchronous FIFO because the write clock domain and the read clock domain operate independently and may have no fixed frequency relationship. This asynchronous behavior introduces challenges such as metastability, which can lead to unreliable data transfer if not properly handled.

### Asynchronus FIFO Module
![image](https://github.com/user-attachments/assets/2ad8fcdd-d9ec-44b3-972e-27028560298c)

### Waveform for Asynchronus FIFO
![image](https://github.com/user-attachments/assets/ba6dab4f-c390-497e-b941-171c5d0c9e5c)

